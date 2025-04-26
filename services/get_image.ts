import { GoogleGenAI } from "@google/genai";
import * as fs from "node:fs";
import * as path from "node:path";
import { config } from "dotenv";

// Load environment variables
config();

interface ImageDetails {
  path: string;
  mimeType: string;
}

// For type safety with the Gemini API
type InlineDataPart = {
  inlineData: {
    mimeType: string;
    data: string;
  };
};

type TextPart = string;

type Part = TextPart | InlineDataPart;

class ImageProcessor {
  private ai: GoogleGenAI;
  private readonly mockDataDir: string;
  
  constructor(apiKey: string) {
    this.ai = new GoogleGenAI({ apiKey });
    this.mockDataDir = path.join(process.cwd(), 'mock_data');
  }
  
  /**
   * Gets all image files from the mock_data directory
   */
  private getImageFiles(): ImageDetails[] {
    try {
      const files = fs.readdirSync(this.mockDataDir);
      const imageFiles: ImageDetails[] = [];
      
      for (const file of files) {
        // Skip hidden files like .DS_Store
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
  
  /**
   * Processes all images in the mock_data folder
   */
  public async processAllImages(): Promise<Record<string, string>> {
    const imageFiles = this.getImageFiles();
    if (imageFiles.length === 0) {
      console.warn('No image files found in mock_data directory');
      return {};
    }
    
    console.log(`Found ${imageFiles.length} images to process`);
    
    const results: Record<string, string> = {};
    
    for (const imageFile of imageFiles) {
      try {
        const caption = await this.captionSingleImage(imageFile);
        const fileName = path.basename(imageFile.path);
        results[fileName] = caption;
        console.log(`✅ Processed: ${fileName}`);
      } catch (error) {
        console.error(`❌ Error processing ${path.basename(imageFile.path)}:`, error);
      }
    }
    
    return results;
  }
  
  /**
   * Process multiple images together to compare them
   */
  public async compareImages(promptText: string = "What is shown in these images?"): Promise<string> {
    const imageFiles = this.getImageFiles();
    if (imageFiles.length < 2) {
      throw new Error('Need at least 2 images to compare');
    }
    
    try {
      // Start with the text prompt
      const contentParts: Part[] = [promptText];
      
      // Process images
      for (const imageFile of imageFiles) {
        const base64ImageData = fs.readFileSync(imageFile.path, { encoding: 'base64' });
        const imagePart: InlineDataPart = {
          inlineData: {
            mimeType: imageFile.mimeType,
            data: base64ImageData
          }
        };
        contentParts.push(imagePart);
      }
      
      // Create a model instance for the Gemini API
      const model = this.ai.getGenerativeModel({ model: "gemini-2.0-flash" });
      
      // Generate the content
      const result = await model.generateContent(contentParts);
      const response = await result.response;
      
      return response.text();
    } catch (error) {
      console.error('Error comparing images:', error);
      throw error;
    }
  }
  
  /**
   * Captions a single image using Gemini API
   */
  private async captionSingleImage(imageFile: ImageDetails): Promise<string> {
    try {
      // Read the image and convert to base64
      const base64ImageData = fs.readFileSync(imageFile.path, { encoding: 'base64' });
      
      // Create the image part
      const imagePart: InlineDataPart = {
        inlineData: {
          mimeType: imageFile.mimeType,
          data: base64ImageData
        }
      };
      
      // Create content parts
      const contentParts: Part[] = [
        "Describe what's in this image in detail",
        imagePart
      ];
      
      // Create a model instance for the Gemini API
      const model = this.ai.getGenerativeModel({ model: "gemini-2.0-flash" });
      
      // Generate the content
      const result = await model.generateContent(contentParts);
      const response = await result.response;
      
      return response.text();
    } catch (error) {
      console.error(`Error processing image ${imageFile.path}:`, error);
      throw error;
    }
  }
  
  /**
   * Process a specific list of images
   */
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

/**
 * Main function to process all images in the mock_data folder
 */
async function main(): Promise<void> {
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
    
  } catch (error) {
    console.error('Error in main function:', error);
  }
}

// Export the main function and ImageProcessor class for external use
export { main, ImageProcessor };

// Run the main function if this file is executed directly
if (require.main === module) {
  main().catch(console.error);
}
import {
  GoogleGenAI,
  createUserContent,
  createPartFromUri,
} from "@google/genai";
import * as fs from "node:fs";

// Mock data setup
const mockUploadResponse = {
  uri: "file://mock/image1.jpg",
  mimeType: "image/jpeg",
};

const mockGenerateContentResponse = {
  text: "Mock response: The first image shows a concert stage with bright lights, while the second image shows a close-up of a musical instrument.",
};

// Mock version of the GoogleGenAI class
class MockGoogleGenAI {
  files = {
    upload: async () => mockUploadResponse,
  };
  
  models = {
    generateContent: async () => mockGenerateContentResponse,
  };
}

async function main() {
  // Use the mock API instead of real API
  const ai = new MockGoogleGenAI();
  
  // Instead of reading real files, we can use mock file paths
  const image1_path = "mock/path/to/image1.jpg";
  const image2_path = "mock/path/to/image2.png";
  
  // Mock upload for first image
  const uploadedFile = await ai.files.upload({
    file: image1_path,
    config: { mimeType: "image/jpeg" },
  });

  // For testing, we can either use a real base64 string or a placeholder
  // Mock base64 data (this is just a placeholder, not real base64 data)
  const mockBase64Image = "mocked_base64_data_would_be_here";
  
  // Use the mock functions but keep the original code structure
  const response = await ai.models.generateContent({
    model: "gemini-2.0-flash",
    contents: createUserContent([
      "What is different between these two images?",
      createPartFromUri(uploadedFile.uri, uploadedFile.mimeType),
      {
        inlineData: {
          mimeType: "image/png",
          data: mockBase64Image,
        },
      },
    ]),
  });
  
  console.log(response.text);
}

await main();