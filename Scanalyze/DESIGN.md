The project was implemented as a FLASK site. Multiple HTML pages were used in combination with python app to create an interactive, front-end and back-end integration allowing for a webtool that works with SQLlite3 databases such as this one.

Beyond this page, notes are found throughout the code detailing how things were done.

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Database:

The database includes the user-inputted metadata for the images, names of the image file uploaded, and information about the date, time, and user id's associated with each image upload. The images themselves are not stored in the sql databases as then files shared across multiple accounts would cause redundancy and unnecessary load through frequent blobbing and unblobbing of images once the database and respective user dashboards become larger and larger.

Hence, the structure of the database to include only file names rather than the actual blobbed images themselves allows uploaded files to be stored in a folder on the server. In addition, it allows for the storage of actual full 3D MRI filetypes such as Nifti, Dicom, and .tif, making it viable to upload and be able to access filetypes which cannot be stored in SQL, like the vast majority of MRI files.

This structure, beyond allowing diverse filetypes, reduced redundancy (where only copies of file names are shared among users rather than copies of the file), also ensures that files deleted by sql queries initiated by individual users are allowed to remain in the records of hospital networks using the program and on the dashboards of users who also share access to them.

Uploading and sharing files results in the creation of new rows in the table of scans, with elements of the sharing user's request being copied to the new row with the receiving user's user id.

Lookups, deletes, uploads, and shares are all facilitated by queries and commands based on a users database and a scans database in different combinations.

Users, facilitating logins, registrations, and displaying colleagues' names when sharing a file, contains a user id, username, and password for each user

Scans contains columns of patient name, mri modality, file name, date, and user_id for the user uploading the image or the user receiving the image from a colleague. This is used to pull and work with all data and to store all user uploads.

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Front End

The design is intended to emulate a dashboard system with the ability to easily navigate through multiple pages with differing functionalities, quite like Finance Pset. The styling includes glows, borders, firmly structured and held in place footers, headers, and body elements which are adaptable to changes in size and usable on mobile. The visual aesthetic aims to be a reserved yet sophisticated dynamic background with a shifting gradient of greys and floaters flying up through the page (implemented with creating multiple elements of a list called "particles" on every page and downloading a pre-made css template and modifying its color scheme, speed, and size to be more reserved in order to animate a more reserved and calm version of the online css background.)

All this is done deliberately to provide visually aesthetic design but also allow the user to remain focused and not be overly distracted or overwhelmed.

User IDs are always displayed as a stylistic choice so that a person with multiple user accounts can remember where they are logged in. Dropdowns are used to maintain ease of use for the user in searching, deleting, and sharing files already in the database.

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Machine Learning

This model was originally to be implemented directly into the website however with issues surrounding the java wrapper that was needed to run imageJ, FIJI, and Weka within python, this was largely unsuccessful. As an alternative, 2 downloads are provided, one for the software needed and one for the model that I had configured trained personally to segment the tissues within the MRI automatically. Simple instructions are provided to allow a user to easily download files from the site and run them through the machine learning model on the Weka GUI seperately, with the webapp software essentially being (temporarily) a supporting tool to the WEKA GUI and machine learning model.