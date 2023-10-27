const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: 'jimmysuthar08@gmail.com',
        pass: 'ylzallnhcosdpsui'
    }
});


const sendEmail = async (req, res, next) => {
    const data = req.body;

    const info = await transporter.sendMail({
        from: '"Blog Wave" <jimmysuthar08@gmail.com>', // sender address
        to: data.email, // list of receivers
        subject: `Hello ${data.bloggerName}`, // Subject line
        text: "Hello world?", // plain text body
        html: `<!DOCTYPE html>
        <html>
        <head>
            <style>
                .container {
                    text-align: center;
                }
                .icon {
                    display: inline-block;
                    font-size: 36px;
                    margin: 10px;
                }
                h1 {
                    background-color: teal;
                    color: white;
                    padding: 10px;
                    font-family: 'Dancing Script', cursive;
                }
                .center-content {
                    text-align: center;
                }
            </style>
            <link href="https://fonts.googleapis.com/css?family=Dancing+Script" rel="stylesheet">
        </head>
        <body>
            <div class="container">
                <h1>Blog Wave</h1>
                <div class="center-content">
                    <img src="https://firebasestorage.googleapis.com/v0/b/blogapp-53499.appspot.com/o/usersProfile%2F276e63d2-a0dc-43fb-9327-67a2c9e294a8%2Fv-r3ix0SpIdFr6YajxGrbGzxNdY%3D?alt=media&token=62e3392a-d30b-49cb-94c5-363db5f793fc" alt="Network Icon" width="100" height="100">
                    <h2>Hello, Greetings!</h2>
                </div>
                
                <h3>${data.title} </h3>
                <p>${data.message}</p>
            </div>
        </body>
        </html>` // html body
    }).then((method) => {
        console.log("Message sent: %s", method.messageId);
        return res.status(200).json({
            Message: "Mail Send Successfully"
        });
    });
}; 


module.exports=sendEmail;