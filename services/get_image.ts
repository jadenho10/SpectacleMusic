import { GoogleGenerativeAI } from "@google/generative-ai";
import * as fs from "node:fs";
import * as path from "node:path";
import { config } from "dotenv";

config();

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
    
  private async captionSingleImage(imageFile: ImageDetails): Promise<string> {
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

function runImageProcessor(): Promise<void> {
  return new Promise(async (resolve, reject) => {
    try {
      const apiKey = process.env.GOOGLE_API_KEY || process.env.GEMINI_API_KEY;
      if (!apiKey) {
        throw new Error('API key not found. Please set GOOGLE_API_KEY or GEMINI_API_KEY in .env file');
      }
      
      const processor = new ImageProcessor(apiKey);
      
      console.log('Processing individual images...');
      const captions = await processor.processAllImages();
      console.log('\nImage Captions:');
      console.table(captions);
      
      console.log('\nComparing all images together...');
      const comparison = await processor.compareImages();
      console.log('Comparison Result:\n', comparison);
      
      resolve();
    } catch (error) {
      console.error('Error in main function:', error);
      reject(error);
    }
  });
}

export { runImageProcessor as main, ImageProcessor };

if (require.main === module) {
  runImageProcessor().catch(console.error);
}