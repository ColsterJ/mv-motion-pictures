# mv-motion-pictures
Hello! After cloning the repository, please follow these steps to run the app:
1. First, set up the database by executing the included script `setup_db.sql` in SSMS.
  * This script creates a new database `motionpicturesdb` and a new table `MotionPictures`. It also populates the table with some data.
  * Note: The file paths should match a default installation of SQL Server Express 2019, but double-check them in case yours is installed somewhere other than the default.
2. Using Visual Studio, run the ASP.NET Core backend located in the `MotionPicturesAPI` folder.
3. Double-check the `API_URL` value in `Client\src\api.js`. Your backend may be running on a different port than the one shown. If necessary, update this value. Here's how it's set currently:
```js
const API_URL = "https://localhost:7126/api/MotionPictures";
```
4. Run the Vue.js frontend located in the `Client` folder. You can do this be running the following terminal commands:
```bash
cd Client
npm install
npm run dev
```
5. Finally, control-click the URL shown beside `Local:`, and you should be able to start using the web app.
