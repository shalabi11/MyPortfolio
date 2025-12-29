# Project Dashboard Guide

## Overview

The Project Dashboard is a comprehensive management system for your portfolio projects. It allows you to add, edit, delete, and manage projects without manually editing JSON files.

## Features

### 1. **Add New Projects**
- Click the "Add Project" button to open the add project dialog
- Fill in all required project details:
  - **Project Title**: Name of your project
  - **Description**: Detailed description of what the project does
  - **Project URL**: Link to GitHub repository or project website
  - **Gallery/Demo URL** (Optional): Live demo or gallery link
  - **App Distribution URL** (Optional): Firebase App Distribution link
  - **Technologies**: Multi-select technology stack (add one at a time)
  - **Project Image**: Upload a thumbnail image for the project

### 2. **View & Manage Projects**
- All projects are displayed in a responsive grid/list view
- Each project card shows:
  - Project image/thumbnail
  - Title and description
  - Technology stack badges
  - Date added
  - Edit and Delete buttons

### 3. **Edit Projects**
- Click the "Edit" button on any project card
- Modify any project details
- Changes are saved immediately to the local database

### 4. **Delete Projects**
- Click the "Delete" button to remove a project
- A confirmation dialog will appear
- Deleted projects cannot be recovered

### 5. **Search Projects**
- Use the search bar to find projects by title or description
- Results update in real-time as you type
- Click the clear button to reset the search

### 6. **Filter by Technology**
- Click on any technology chip to filter projects
- Shows only projects that use the selected technology
- Click the technology chip again to remove the filter
- Use the "More..." dropdown to access additional technologies

## Local Database

Projects are stored locally using **Hive**, a lightweight Flutter database. This means:
- ✅ No internet required
- ✅ Fast performance
- ✅ Data persists across app sessions
- ✅ Easy to backup and restore

## Data Integration

### Automatic Sync with Portfolio Page
- All projects added in the dashboard automatically appear on the home/portfolio page
- No manual refresh needed - changes appear immediately
- The portfolio page now pulls data from the local database instead of JSON files

### Project Model Compatibility
The dashboard uses an enhanced project model that includes:
- Unique project ID (auto-generated)
- Date added and modified timestamps
- Optional local image storage
- All original project fields (technologies, URLs, etc.)

## Navigation

### Accessing the Dashboard

**Desktop/Web View:**
- Click the Dashboard icon (📊) in the top navigation bar

**Mobile View:**
- Tap the menu button (☰) to open the drawer
- Select "Dashboard"

## Best Practices

1. **Use Meaningful Project Titles**: Make titles clear and descriptive
2. **Write Detailed Descriptions**: Help viewers understand what the project does
3. **Add All Technologies**: Include every technology used in the project
4. **Use High-Quality Images**: Upload clear, professional-looking project thumbnails
5. **Keep URLs Updated**: Ensure all links are working and current

## Technical Details

### Database Structure
```
Project (Hive Box)
├── ID (UUID)
├── Title
├── Description
├── Technologies (List)
├── Project URL
├── Gallery URL (Optional)
├── App Distribution URL (Optional)
├── Feature Image Paths (List)
├── Date Added
├── Date Modified
└── Local Image Path (Optional)
```

### Data Storage Location
- **iOS/Android**: App's documents directory
- **Web**: Browser's local storage
- **Desktop**: App's data directory

### Supported File Types
- **Images**: PNG, JPG, JPEG
- **Maximum image size**: No hard limit, but recommended < 5MB for performance

## Troubleshooting

### Projects Not Appearing
1. Verify the database was initialized (should happen automatically)
2. Check that you clicked the "Save" button
3. Reload the app (hot reload or restart)

### Can't Upload Images
1. Check file permissions
2. Ensure the file is a valid image format
3. Try a smaller file size

### Data Not Persisting
1. The app needs permission to write to storage
2. Check device storage space
3. Reinstall the app if issues persist

## Future Enhancements

Planned features for future updates:
- 📤 Export projects to JSON
- 📥 Import projects from JSON/CSV
- 🔄 Cloud backup and sync
- 📊 Project analytics and statistics
- 🏷️ Project categories and tags
- ⭐ Featured projects selection

## Getting Started

1. Navigate to the Dashboard from the portfolio home page
2. Click "Add Project"
3. Fill in your project details
4. Upload a project image
5. Add technologies using the technology input field
6. Click "Save"
7. Your project will appear immediately in the dashboard and on the home page

Enjoy managing your projects! 🚀
