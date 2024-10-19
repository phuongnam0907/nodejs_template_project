#!/bin/bash

if [ -f "env.config" ]; then
  echo "Template is generated already!!"
  exit 0;
fi

PROJECT_DIR="$(basename $PWD)"

mkdir "data"
mkdir "utils"
mkdir "views"
mkdir "middleware"
mkdir -p "api/routes"

touch "api/routes/"$PROJECT_DIR".js"
touch "api/router.js"
touch "data/data.json"
touch "utils/functions.js"
touch "views/404.ejs"
touch "middleware/authorize.js"
touch "env.config"
touch $PROJECT_DIR".js"

upper_str=$(echo "$PROJECT_DIR" | awk '{ print toupper($0) }')
no_under_str=$(echo "${PROJECT_DIR//_}")
first_upper_str=$(echo "$PROJECT_DIR" | tr '[a-z]' '[A-Z]')
replace_under_str=$(echo "${first_upper_str/_/ }")

cat <<EOF > "middleware/authorize.js"
const CONFIG = require("../env.config");

function validate(req, res, next) {
  if (req.query.user || req.body.user) {
    next();
  } else {
    res.status(403).json({ message: 'Access denied' });
  }
}

module.exports = { validate };
EOF

cat <<EOF > "api/routes/"$PROJECT_DIR".js"
const express = require("express");
const authorization = require('../../middleware/authorize');
const router = express.Router();

const CONFIG = require("../../env.config");

router.use(express.json());

router.get("/test", (req, res) => {
  res.status(200).send({message: "ok"});
});

router.post("/test", authorization.validate, (req, res) => {
  res.status(200).send({message: "ok"});
});

// Export Router
module.exports = router;
EOF

cat <<EOF > "api/router.js"
const express = require("express");
const router = express.Router();

// Import Routes Sub-Class
// Add more HERE

const ${no_under_str}Route = require("./routes/${PROJECT_DIR}");
router.use("/", ${no_under_str}Route);

// Export Router
module.exports = router;
EOF

cat <<EOF > "utils/functions.js"
const CONFIG = require("../env.config");

function FunctionTemplateInterval() {
  FunctionTemplate();
  setInterval(function () {
    FunctionTemplate();
  }, 1000);
}

function FunctionTemplate() {
  return 0;
}

module.exports = { FunctionTemplateInterval };
EOF


cat <<EOF > "views/404.ejs"
<html>
  <head>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
    <style type="text/css">
      @import url("https://fonts.googleapis.com/css?family=Montserrat:400,600,700");
      @import url("https://fonts.googleapis.com/css?family=Catamaran:400,800");
      .error-container {
        text-align: center;
        font-size: 106px;
        font-family: "Catamaran", sans-serif;
        font-weight: 800;
        margin: 70px 15px;
      }
      .error-container > span {
        display: inline-block;
        position: relative;
      }
      .error-container > span.four {
        width: 136px;
        height: 43px;
        border-radius: 999px;
        background: linear-gradient(
            140deg,
            rgba(0, 0, 0, 0.1) 0%,
            rgba(0, 0, 0, 0.07) 43%,
            transparent 44%,
            transparent 100%
          ),
          linear-gradient(
            105deg,
            transparent 0%,
            transparent 40%,
            rgba(0, 0, 0, 0.06) 41%,
            rgba(0, 0, 0, 0.07) 76%,
            transparent 77%,
            transparent 100%
          ),
          linear-gradient(to right, #d89ca4, #e27b7e);
      }
      .error-container > span.four:before,
      .error-container > span.four:after {
        content: "";
        display: block;
        position: absolute;
        border-radius: 999px;
      }
      .error-container > span.four:before {
        width: 43px;
        height: 156px;
        left: 60px;
        bottom: -43px;
        background: linear-gradient(
            128deg,
            rgba(0, 0, 0, 0.1) 0%,
            rgba(0, 0, 0, 0.07) 40%,
            transparent 41%,
            transparent 100%
          ),
          linear-gradient(
            116deg,
            rgba(0, 0, 0, 0.1) 0%,
            rgba(0, 0, 0, 0.07) 50%,
            transparent 51%,
            transparent 100%
          ),
          linear-gradient(to top, #99749d, #b895ab, #cc9aa6, #d7969e, #e0787f);
      }
      .error-container > span.four:after {
        width: 137px;
        height: 43px;
        transform: rotate(-49.5deg);
        left: -18px;
        bottom: 36px;
        background: linear-gradient(
          to right,
          #99749d,
          #b895ab,
          #cc9aa6,
          #d7969e,
          #e0787f
        );
      }
      .error-container > span.zero {
        vertical-align: text-top;
        width: 156px;
        height: 156px;
        border-radius: 999px;
        background: linear-gradient(
            -45deg,
            transparent 0%,
            rgba(0, 0, 0, 0.06) 50%,
            transparent 51%,
            transparent 100%
          ),
          linear-gradient(
            to top right,
            #99749d,
            #99749d,
            #b895ab,
            #cc9aa6,
            #d7969e,
            #ed8687,
            #ed8687
          );
        overflow: hidden;
        animation: bgshadow 5s infinite;
      }
      .error-container > span.zero:before {
        content: "";
        display: block;
        position: absolute;
        transform: rotate(45deg);
        width: 90px;
        height: 90px;
        background-color: transparent;
        left: 0px;
        bottom: 0px;
        background: linear-gradient(
            95deg,
            transparent 0%,
            transparent 8%,
            rgba(0, 0, 0, 0.07) 9%,
            transparent 50%,
            transparent 100%
          ),
          linear-gradient(
            85deg,
            transparent 0%,
            transparent 19%,
            rgba(0, 0, 0, 0.05) 20%,
            rgba(0, 0, 0, 0.07) 91%,
            transparent 92%,
            transparent 100%
          );
      }
      .error-container > span.zero:after {
        content: "";
        display: block;
        position: absolute;
        border-radius: 999px;
        width: 70px;
        height: 70px;
        left: 43px;
        bottom: 43px;
        background: #fdfaf5;
        box-shadow: -2px 2px 2px 0px rgba(0, 0, 0, 0.1);
      }
      .screen-reader-text {
        position: absolute;
        top: -9999em;
        left: -9999em;
      }
      @keyframes bgshadow {
        0% {
          box-shadow: inset -160px 160px 0px 5px rgba(0, 0, 0, 0.4);
        }
        45% {
          box-shadow: inset 0px 0px 0px 0px rgba(0, 0, 0, 0.1);
        }
        55% {
          box-shadow: inset 0px 0px 0px 0px rgba(0, 0, 0, 0.1);
        }
        100% {
          box-shadow: inset 160px -160px 0px 5px rgba(0, 0, 0, 0.4);
        }
      }
      /* demo stuff */
      * {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
      }
      body {
        background-color: #fdfaf5;
        margin-bottom: 50px;
      }
      html,
      button,
      input,
      select,
      textarea {
        font-family: "Montserrat", Helvetica, sans-serif;
        color: #bbb;
      }
      h1 {
        text-align: center;
        margin: 30px 15px;
      }
      .zoom-area {
        max-width: 490px;
        margin: 30px auto 30px;
        font-size: 19px;
        text-align: center;
      }
      .link-container {
        text-align: center;
      }
      a.more-link {
        text-transform: uppercase;
        font-size: 13px;
        background-color: #de7e85;
        padding: 10px 15px;
        border-radius: 0;
        color: #fff;
        display: inline-block;
        margin-right: 5px;
        margin-bottom: 5px;
        line-height: 1.5;
        text-decoration: none;
        margin-top: 50px;
        letter-spacing: 1px;
      }
      .element {
        max-width: fit-content;
        margin-left: auto;
        margin-right: auto;
      }
      .container {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        gap: 15px;
      }
      #footer {
        position: fixed;
        bottom: 0;
        width: 100%;
      }
    </style>
  </head>
  <body>
    <h1><b><%= project_name %></b></h1>
    <p class="zoom-area">PAGE NOT FOUND</p>
    <section class="error-container">
      <span class="four"><span class="screen-reader-text">4</span></span>
      <span class="zero"><span class="screen-reader-text">0</span></span>
      <span class="four"><span class="screen-reader-text">4</span></span>
    </section>
    <div class="link-container">
      <a target="_blank" href="http://<%= author_page %>" class="more-link"
        >Contact to <%= author_name %></a
      >
    </div>

    <div id="footer" class="container list-group">
      <a
        target="_blank"
        href="https://www.facebook.com/<%= facebook %>"
        class="list-group-item"
        ><i class="fa fa-facebook-square fa-2x"></i
      ></a>
      <a
        target="_blank"
        href="https://github.com/<%= github %>"
        class="list-group-item"
        ><i class="fa fa-github-square fa-2x"></i
      ></a>
      <a
        target="_blank"
        href="https://www.linkedin.com/in/<%= linkedin %>"
        class="list-group-item"
        ><i class="fa fa-linkedin-square fa-2x"></i
      ></a>
      <a
        target="_blank"
        href="https://www.youtube.com/<%= youtube %>"
        class="list-group-item"
        ><i class="fa fa-youtube-square fa-2x"></i
      ></a>
      <a
        target="_blank"
        href="https://zalo.me/<%= zalo %>"
        class="list-group-item"
        ><i class="fa fa-envelope-square fa-2x"></i
      ></a>
    </div>
  </body>
</html>
EOF

cat <<EOF > "env.config"
module.exports = {
    project: {
        name: "${replace_under_str} Server",
        name_upper: "${upper_str} SERVER"
    },
    port: 5200x,
    data_json_file: "data/data.json",
    author: {
        name: "Le Phuong Nam",
        email: "phuongnam0907@gmail.com",
        facebook_old: "phuongnam09071997",
        facebook: "namlephuong1997",
        github: "phuongnam0907",
        linkedin: "nam-le-62999a246",
        youtube: "@phuongnam0907",
        zalo: "0907199700",
        page: "lpnserver.net",
        organize: "npnlab"
    }
}
EOF

cat <<EOF > $PROJECT_DIR".js"
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const morgan = require("morgan");
const responseTime = require("response-time");
const path = require("path");
const func = require('./utils/functions');

const app = express();

const CONFIG = require("./env.config");

var corsOptions = {
  origin: "http://localhost:" + CONFIG.port,
};
app.use(morgan("combined"));
app.use(responseTime());
app.use(cors(corsOptions));

app.set("views", path.join(__dirname, "views"));
app.use(express.static("public", { extensions: ["jsx"] }));
app.set("view engine", "ejs");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const subRoute = require("./api/router");
app.use("/", subRoute);

app.all("*", (req, res) => {
  let obj = {
    project_name: CONFIG.project.name_upper,
    author_page: CONFIG.author.page,
    author_name: CONFIG.author.name,
    facebook: CONFIG.author.facebook,
    github: CONFIG.author.github,
    linkedin: CONFIG.author.linkedin,
    youtube: CONFIG.author.youtube,
    zalo: CONFIG.author.zalo
  };
  res.render("404", obj);
});

app.listen(CONFIG.port, () => {
  console.log(\`Server is running on port CONFIG_port.\`);
});
EOF

editor=$(sed 's/CONFIG_port/\$\{CONFIG.port\}/g' $PROJECT_DIR".js")
echo $editor > $PROJECT_DIR".js"

echo "" >> .gitignore
echo "# From Le Phuong Nam" >> .gitignore
echo "package-lock.json" >> .gitignore

npm init -y
npm i body-parser cors ejs express morgan response-time --save
npm i --save-dev nodemon
npm pkg set 'scripts.dev'="nodemon ${PROJECT_DIR}.js --ignore data/*"
npm pkg set 'scripts.start'="node ${PROJECT_DIR}.js"

git add .
echo "data/" >> .gitignore

git add .
git commit -m "auto generate template code"
git push
