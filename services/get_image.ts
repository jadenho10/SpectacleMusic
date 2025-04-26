import { GoogleGenerativeAI } from "@google/generative-ai";
import * as fs from "node:fs";
import * as path from "node:path";
import { config } from "dotenv";

// Define simple type definitions for the modules we'll use
type Request = any;
type Response = any;
type Multer = any;

// Dynamic imports for the server modules
let express: any;
let multer: any;
let cors: any;

// Load dotenv configuration
config();

// Add a comment indicating the required npm packages
// npm install --save express multer cors

interface ImageDetails {
  path: string;
  mimeType: string;
}

class ImageProcessor {
  private genAI: GoogleGenerativeAI;
  private readonly mockDataDir: string;
  
  /**
   * @param Gemini API Key
   */
  constructor(apiKey: string) {
    this.genAI = new GoogleGenerativeAI(apiKey);
    this.mockDataDir = path.join(process.cwd(), 'mock_data');
  }

  private getImageFiles(): ImageDetails[] {
    try {
      const files = fs.readdirSync(this.mockDataDir);
      const imageFiles: ImageDetails[] = [];
      
      for (const file of files) {
        if (file.startsWith('.')) continue;
        
        const filePath = path.join(this.mockDataDir, file);
        const fileExt = path.extname(file).toLowerCase();
        
        if (fileExt === '.jpg' || fileExt === '.jpeg') {
          imageFiles.push({
            path: filePath,
            mimeType: 'image/jpeg'
          });
        } else if (fileExt === '.png') {
          imageFiles.push({
            path: filePath,
            mimeType: 'image/png'
          });
        }
      }
      
      return imageFiles;
    } catch (error) {
      console.error('Error reading mock_data directory:', error);
      return [];
    }
  }
  
  public async processAllImages(): Promise<Record<string, string>> {
    const imageFiles = this.getImageFiles();
    if (imageFiles.length === 0) {
      console.warn('No image files in mock_data directory');
      return {};
    }
    
    console.log(`${imageFiles.length} images to process`);
    
    const results: Record<string, string> = {};
    
    for (const imageFile of imageFiles) {
      try {
        const caption = await this.captionSingleImage(imageFile);
        const fileName = path.basename(imageFile.path);
        results[fileName] = caption;
        console.log(`✅ Processed: ${fileName}`);
      } catch (error) {
        console.error(`❌ Error ${path.basename(imageFile.path)}:`, error);
      }
    }
    return results;
  }
    
  public async captionSingleImage(imageFile: ImageDetails): Promise<string> {
    try {
      const model = this.genAI.getGenerativeModel({ model: "gemini-1.5-pro" });
      const imageData = fs.readFileSync(imageFile.path);      
      const chat = model.startChat();
      
      const parts: any[] = [
        { text: "Describe what's in this image in detail" },
        {
          inlineData: {
            mimeType: imageFile.mimeType,
            data: Buffer.from(imageData).toString('base64')
          }
        }
      ];
      
      const result = await chat.sendMessage(parts);
      
      const responseText = result.response.text();
      return responseText;
    } catch (error) {
      console.error(`Error processing image ${imageFile.path}:`, error);
      throw error;
    }
  }
  
  public async uploadImage(imagePath: string): Promise<{ uri: string; mimeType: string }> {
    try {
      const fullPath = path.isAbsolute(imagePath) ? imagePath : path.join(this.mockDataDir, imagePath);
      const fileExt = path.extname(fullPath).toLowerCase();
      let mimeType = 'image/jpeg';
      
      if (fileExt === '.png') {
        mimeType = 'image/png';
      }
      
      return {
        uri: `file://${fullPath}`,
        mimeType
      };
    } catch (error) {
      console.error(`Error uploading image ${imagePath}:`, error);
      throw error;
    }
  }
  
  public async processSpecificImages(imagePaths: string[]): Promise<Record<string, string>> {
    const results: Record<string, string> = {};
    
    for (const imagePath of imagePaths) {
      try {
        const fullPath = path.isAbsolute(imagePath) ? imagePath : path.join(this.mockDataDir, imagePath);
        const fileExt = path.extname(fullPath).toLowerCase();
        let mimeType = 'image/jpeg';
        
        if (fileExt === '.png') {
          mimeType = 'image/png';
        }
        
        const imageFile: ImageDetails = {
          path: fullPath,
          mimeType
        };
        
        const caption = await this.captionSingleImage(imageFile);
        const fileName = path.basename(fullPath);
        results[fileName] = caption;
        console.log(`✅ Processed: ${fileName}`);
      } catch (error) {
        console.error(`❌ Error processing ${imagePath}:`, error);
      }
    }
    
    return results;
  }
}

// Setup Express server
function setupWebhookServer(): void {
  // Dynamically import the modules
  try {
    express = require('express');
    multer = require('multer');
    cors = require('cors');
  } catch (error) {
    console.error('Error importing required modules:', error);
    console.log('Please install the necessary packages with: npm install express multer cors');
    return;
  }
  
  const app = express();
  const PORT = process.env.PORT || 3000;
  const apiKey = process.env.GEMINI_API_KEY;
  
  if (!apiKey) {
    throw new Error('GEMINI_API_KEY must be set in environment variables');
  }
  
  const processor = new ImageProcessor(apiKey);
  
  // Configure multer for file uploads
  const storage = multer.diskStorage({
    destination: (req: any, file: any, cb: any) => {
      const uploadDir = path.join(process.cwd(), 'uploads');
      if (!fs.existsSync(uploadDir)) {
        fs.mkdirSync(uploadDir, { recursive: true });
      }
      cb(null, uploadDir);
    },
    filename: (req: any, file: any, cb: any) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
      cb(null, uniqueSuffix + path.extname(file.originalname));
    }
  });
  
  const upload = multer({ storage });
  
  // Middleware
  app.use(cors());
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  
  // Health check endpoint
  app.get('/health', (req: any, res: any) => {
    res.status(200).json({ status: 'ok' });
  });
  
  // Add a GET endpoint for processing an image by path
  app.get('/process-image', async (req: any, res: any) => {
    try {
      const imagePath = req.query.path;
      
      if (!imagePath || typeof imagePath !== 'string') {
        return res.status(400).json({ 
          error: 'No image path provided', 
          example: '/process-image?path=example.jpg' 
        });
      }
      
      // Create image details for the file
      const fullPath = path.isAbsolute(imagePath) ? imagePath : path.join(processor.mockDataDir, imagePath);
      
      if (!fs.existsSync(fullPath)) {
        return res.status(404).json({ error: `Image not found at path: ${fullPath}` });
      }
      
      const fileExt = path.extname(fullPath).toLowerCase();
      let mimeType = 'image/jpeg';
      
      if (fileExt === '.png') {
        mimeType = 'image/png';
      }
      
      const imageFile: ImageDetails = {
        path: fullPath,
        mimeType
      };
      
      const caption = await processor.captionSingleImage(imageFile);
      
      res.status(200).json({
        success: true,
        fileName: path.basename(fullPath),
        caption
      });
      
    } catch (error: any) {
      console.error('Error processing image by path:', error);
      res.status(500).json({ error: 'Failed to process image', details: error.message || String(error) });
    }
  });
  
  // Process a single uploaded image (POST version still needed for file uploads)
  app.post('/process-image', upload.single('image'), async (req: any, res: any) => {
    try {
      if (!req.file) {
        return res.status(400).json({ error: 'No image file provided' });
      }
      
      const imageFile: ImageDetails = {
        path: req.file.path,
        mimeType: req.file.mimetype
      };
      
      const caption = await processor.captionSingleImage(imageFile);
      
      res.status(200).json({
        success: true,
        fileName: req.file.originalname,
        caption
      });
      
      // Clean up the uploaded file
      fs.unlinkSync(req.file.path);
      
    } catch (error: any) {
      console.error('Error processing uploaded image:', error);
      res.status(500).json({ error: 'Failed to process image', details: error.message || String(error) });
    }
  });
  
  // Process multiple images from the mock_data directory
  app.get('/process-all', async (req: any, res: any) => {
    try {
      const captions = await processor.processAllImages();
      res.status(200).json({
        success: true,
        captions
      });
    } catch (error: any) {
      console.error('Error processing all images:', error);
      res.status(500).json({ error: 'Failed to process images', details: error.message || String(error) });
    }
  });
  
  // Process specific images from the mock_data directory
  app.get('/process-specific', async (req: any, res: any) => {
    try {
      // Get images from query parameter instead of body
      const imagesParam = req.query.images;
      let images = [];
      
      if (typeof imagesParam === 'string') {
        // Handle single image passed as string
        images = [imagesParam];
      } else if (Array.isArray(imagesParam)) {
        // Handle array of images
        images = imagesParam;
      }
      
      if (!images || images.length === 0) {
        return res.status(400).json({ error: 'Invalid or empty images query parameter. Use ?images=image1.jpg or ?images[]=image1.jpg&images[]=image2.png' });
      }
      
      const captions = await processor.processSpecificImages(images);
      res.status(200).json({
        success: true,
        captions
      });
    } catch (error: any) {
      console.error('Error processing specific images:', error);
      res.status(500).json({ error: 'Failed to process specific images', details: error.message || String(error) });
    }
  });
  
  // Start the server
  app.listen(PORT, () => {
    console.log(`Image processing webhook server running on port ${PORT}`);
  });
}

export { setupWebhookServer as main, ImageProcessor };

if (require.main === module) {
  setupWebhookServer();
}