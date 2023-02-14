Scanalyze.ai

Youtube Video: https://youtu.be/eLbkHbRzhW8

This is a webapp used for uploading, storing, accessing, and sharing medical imaging data, as well as functioning as an accompanying repository for an AI-based MRI Segmentation model.

Included in this folder are a flask python app, html pages, css styling, machine learning models to download, sample MRI images to test the software with, a database with some pre-loaded users and images.

The webapp has 6 functionalities once a user has registered and logged in:

1. The webapp allows for uploads of images to its database, to be accessible by the authorized user in the portal. The uploads entail a patient name, a file, an attribute to describe the kind of MRI being uploaded, and the time it was uploaded.

2. A dashboard on the index page allows the logged-in user to view and download all the scans they have uploaded or been granted access to by other users on the webapp along with all relevent information about the images.

3. Once a user has amassed many scans, it may become difficult for a radiologist using the app to perform longitudinal analysis of patient development over time or across different modalities of MRI. Thus, a third functionality is allowing the user to search images within their authorization by patient name to only view scans belonging to the patient they are examining at the moment. This can be found in lookup.

4. Medical images often need to be shared among members of the healthcare team. The neurologists, radiologists, MRI technicians, and Hospitalists may all need to access and view images at times. Thus, on the share file page, a user may share any scan that they have access to with any person on the network.

5. Once a user has done what is needed with their images, they are able to delete entries from their dashboard. This, notably, does not delete the file itself on the server, meaning that other users will still be able to access them. If every user deletes an entry, the file itself still remains on the server, as medical imaging data needs to have a record and history, hence making it impossible to delete any uploaded file as a user. Only an administrator with access to the server may do so.

6. The 2nd part of the project entails linking with the custom-made Scanalyze Machine Learning Model for automated MRI analysis and Tissue Segmentation. The Download Scanalyzer page includes download links for the relevent model and software as well as instructions for use.

NOTE: the segmentation model only works with .tif files as MRIs are typically 3D images and the classifier is a 3D classifier. tif images and sample jpegs have been provided in the TestScans folder. It will not work with any other filetype.

The site can be run using "Flask Run" in the Command Line. No Setup Required.

A sample login you may use to see a dashboard with images already uploaded is:

username: Arjan
password: 88king88

Sample images and .tif files are provided in TestScans for testing of the site.