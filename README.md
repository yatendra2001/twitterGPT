



<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/yatendra2001/twitter_gpt">
    <img src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/49fgso0w25bdidk930ay.png"  alt="Logo" width="200" height="200" >
  </a>
  
</div>

## TwitterGPT

TwitterGPT aims to bring the power of AI to social media, starting with Twitter. It allows users to automate their Twitter content generation, personalizing tweets and threads based on their unique style and preferred topics.

![App Screenshot](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hoaaauh44j4sfo5leee9.png)


## Introduction

TwitterGPT is a web app that utilizes OpenAI's GPT-4 to simplify the Twitter content creation process, making it accessible to a wider audience. The AI-generated content is unique and reflects the personal preferences and styles of the user, resulting in personalized Twitter threads.


## Usage

1. Clone the repository from GitHub:

```bash
git clone https://github.com/your-github-username/twittergpt.git
```

2. Create a .env file under the root directory and set up the following environment variables:

```bash
# Twitter Credentials
ACCESS_TOKEN=Your_Twitter_Access_Token
ACCESS_TOKEN_SECRET=Your_Twitter_Access_Token_Secret

API_KEY=Your_Twitter_API_Key
API_SECRET_KEY=Your_Twitter_API_Secret_Key
BEARER_TOKEN=Your_Twitter_Bearer_Token

CALLBACK_URL=Your_Callback_URL

CLIENT_ID=Your_Client_ID
CLIENT_SECRET=Your_Client_Secret

# Supabase URL(s)
SUPABASE_CALLBACK_URL=Your_Supabase_Callback_URL
PUBLIC_ANON_KEY=Your_Public_Anon_Key
SUPABASE_PROJECT_URL=Your_Supabase_Project_URL

# Open AI
OPEN_AI_API_KEY=Your_OpenAI_API_Key

# Firebase Credentials
# Firebase Web
API_KEY_WEB=Your_Firebase_Web_API_Key
APP_ID_WEB=Your_Firebase_Web_App_ID
...

(Complete with your other Firebase credentials for Android, iOS, and macOS)
```

3. Check for Flutter setup and connected devices:

```bash
flutter doctor
```

4. Get all dependencies:
```bash
flutter pub get
```

5. Run the app:

```bash
flutter run
```

## Contributing

Contribution to the project can be made if you have some improvements for the project or if you find some bugs.
You can contribute to the project by reporting issues, forking it, modifying the code and making a pull request to the repository.

Please make sure you specify the commit type when opening pull requests:

```
feat: The new feature you're proposing

fix: A bug fix in the project

style: Feature and updates related to UI improvements and styling

test: Everything related to testing

docs: Everything related to documentation

refactor: Regular code refactoring and maintenance
```

## License

The project is released under the [MIT License](http://www.opensource.org/licenses/mit-license.php). The license can be found [here](LICENSE).

## Flutter

For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### If you like it, make sure to star our repo :)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/yatendra2001/twitter_gpt.svg?style=for-the-badge
[contributors-url]: https://github.com/yatendra2001/twitter_gpt/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/yatendra2001/twitter_gpt.svg?style=for-the-badge
[forks-url]: https://github.com/yatendra2001/twitter_gpt/network/members
[stars-shield]: https://img.shields.io/github/stars/yatendra2001/twitter_gpt.svg?style=for-the-badge
[stars-url]: https://github.com/yatendra2001/twitter_gpt/stargazers
[issues-shield]: https://img.shields.io/github/issues/yatendra2001/twitter_gpt.svg?style=for-the-badge
[issues-url]: https://github.com/yatendra2001/twitter_gpt/issues
[license-shield]: https://img.shields.io/github/license/yatendra2001/twitter_gpt.svg?style=for-the-badge
[license-url]: https://github.com/yatendra2001/twitter_gpt/blob/master/LICENSE
