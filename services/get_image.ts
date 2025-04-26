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
  
  /**
   * Gets all image files from the mock_data directory
   * @returns Array of image file details
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
   * Process all images in the mock_data folder and generate captions
   * @returns Record of image names to captions
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
   * Compare multiple images and describe the differences
   * @param promptText - Optional text prompt to use for comparing images
   * @returns Text description of image comparison
   */
  public async compareImages(promptText: string = "What is different between these images?"): Promise<string> {
    const imageFiles = this.getImageFiles();
    if (imageFiles.length < 2) {
      throw new Error('Need at least 2 images to compare');
    }
    
    try {
      // Get the model
      const model = this.genAI.getGenerativeModel({ model: "gemini-1.5-pro" });
      
      // Create a chat session
      const chat = model.startChat();
      
      // Prepare parts for message
      const parts: any[] = [];
      
      // Add the text part
      parts.push({
        text: promptText
      });
      
      // Add each image as a part
      for (const imageFile of imageFiles) {
        const imageData = fs.readFileSync(imageFile.path);
        parts.push({
          inlineData: {
            mimeType: imageFile.mimeType,
            data: Buffer.from(imageData).toString('base64')
          }
        });
      }
      
      // Send the message with all parts
      const result = await chat.sendMessage(parts);
      
      // Get the response text
      const responseText = result.response.text();
      return responseText;
    } catch (error) {
      console.error('Error comparing images:', error);
      throw error;
    }
  }
  
  /**
   * Captions a single image using Gemini API
   * @param imageFile - Image file details
   * @returns Text caption for the image
   */
  private async captionSingleImage(imageFile: ImageDetails): Promise<string> {
    try {
      // Get the model
      const model = this.genAI.getGenerativeModel({ model: "gemini-1.5-pro" });
      
      // Read the image data
      const imageData = fs.readFileSync(imageFile.path);
      
      // Create a chat session
      const chat = model.startChat();
      
      // Prepare parts for message with prompt and image
      const parts: any[] = [
        { text: "Describe what's in this image in detail" },
        {
          inlineData: {
            mimeType: imageFile.mimeType,
            data: Buffer.from(imageData).toString('base64')
          }
        }
      ];
      
      // Send the message with all parts
      const result = await chat.sendMessage(parts);
      
      // Get the response text
      const responseText = result.response.text();
      return responseText;
    } catch (error) {
      console.error(`Error processing image ${imageFile.path}:`, error);
      throw error;
    }
  }
  
  /**
   * Upload an image file to Gemini API and get a URI reference
   * This method is used when you want to reference images across multiple API calls
   * @param imagePath - Path to the image file
   * @returns Object with URI and mime type
   */
  public async uploadImage(imagePath: string): Promise<{ uri: string; mimeType: string }> {
    try {
      const fullPath = path.isAbsolute(imagePath) ? imagePath : path.join(this.mockDataDir, imagePath);
      const fileExt = path.extname(fullPath).toLowerCase();
      let mimeType = 'image/jpeg';
      
      if (fileExt === '.png') {
        mimeType = 'image/png';
      }
      
      // For Gemini API, we don't actually upload files but need their data
      // This is a simplified implementation
      return {
        uri: `file://${fullPath}`,
        mimeType
      };
    } catch (error) {
      console.error(`Error uploading image ${imagePath}:`, error);
      throw error;
    }
  }
  
  /**
   * Process a specific list of images
   * @param imagePaths - Array of image file paths (absolute or relative to mock_data)
   * @returns Record of image names to captions
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

// Export functions and classes for external use
export { runImageProcessor as main, ImageProcessor };

// Run the main function if this file is executed directly
if (require.main === module) {
  runImageProcessor().catch(console.error);
}