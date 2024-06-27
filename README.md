# README

An Article management rails api application
-Devise Authentication
-User Authentication with JWT
-Presenters to present article data
-Kaminari for pagination
-CanCanCan Authorization


======Routes======
=========================================
Register new user  http://localhost:3000/api/v1/auth/sign_up  method=post
example: 
{
  "user": {
    "email": "usertest44444@example.com",
    "password": "password",
    "password_confirmation": "password",
    "role": "user"
  }
}
==========================================
Login User  http://localhost:3000/api/v1/auth/sign_in  method=post
example:
{
  "email": "usertest44444@example.com",
  "password": "password"
}
===========================================
Add new article  http://localhost:3000/api/v1/articles method=post
example:
{
  "article": {
    "title": "Title usertest44444",
    "content": "admin1 content dolor sit amet, consectetur adipiscing elit. Sed et odio quis libero efficitur ultricies."
  }
}
Note: Add token for authorization
=============================================
Get all Article/index   http://localhost:3000/api/v1/articles method=get
=============================================
Get article by Id  http://localhost:3000/api/v1/articles/:id  method=get
=============================================
Update article by Id http://localhost:3000/api/v1/articles/:id method=put
Note: Add token for authorization
=============================================
Delete article by Id http://localhost:3000/api/v1/articles/6 method-delete
Note: Add token for authorization
=============================================


=======start with rails server======