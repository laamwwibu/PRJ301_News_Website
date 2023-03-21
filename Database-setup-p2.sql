Create DATABASE NewWebsite1;

USE NewWebsite1;

CREATE PROC insertUser
@ID INT OUTPUT,
@pass VARCHAR(20),
@name NVARCHAR(50),
@user VARCHAR(60),
@isad BIT,
@gender NVARCHAR(10),
@dob DATE
AS 
BEGIN
	INSERT INTO dbo.UserS
	(
	    User_name,
	    Username,
	    id_Admin,
	    PASSWORD,
		Gender,
		dob
	)
	SELECT @name,@user,@isad,@pass,@gender, @dob
	SET @ID = (SELECT TOP 1 User_id FROM dbo.UserS ORDER BY User_id DESC)
END 


CREATE PROCEDURE InsertUser
    @Name varchar(50),
    @Email varchar(50),
    @Password varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Users (Name, Email, Password)
    VALUES (@Name, @Email, @Password)
    
    SELECT SCOPE_IDENTITY() AS UserID
END



CREATE TABLE UserS(
[User_id] INT IDENTITY(1,1) PRIMARY KEY,
[User_name] NVARCHAR(50),
Gender NVARCHAR(20),
dob DATE,
Username VARCHAR(60),
id_Admin bit,
PASSWORD VARCHAR(20)
);


CREATE TABLE Category(
Cat_id int IDENTITY(1,1) PRIMARY KEY,
Cat_name nvarchar(50),
Cat_description nvarchar(100)
);

CREATE TABLE News (
News_id int IDENTITY(1,1) Primary Key,
[User_id] int FOREIGN KEY REFERENCES UserS([User_id]),
Cat_id int FOREIGN KEY REFERENCES Category(Cat_id),
News_title nvarchar(100),
News_subtitle nvarchar(200),
News_content nvarchar(MAX),
News_image varchar(50)
);


CREATE TABLE Comment(
Comment_id int IDENTITY(1,1) PRIMARY KEY,
[User_id] int FOREIGN KEY REFERENCES UserS([User_id]),
News_id int FOREIGN KEY REFERENCES News(News_id),
Comment_content nvarchar(MAX)
);

CREATE TABLE [Save] (
Save_id int IDENTITY(1,1) PRIMARY KEY,
[User_id] int FOREIGN KEY REFERENCES UserS([User_id]),
News_id int FOREIGN KEY REFERENCES News(News_id),
)

--INSERTING NEWS
CREATE PROCEDURE insert_news (
	@User_id int,
    @Cat_id int,	
	@News_title nvarchar(100),
	@News_subtitle nvarchar(50),
	@News_content nvarchar (MAX),
	@News_image varchar(30)
	)
AS 
BEGIN 
     INSERT INTO News
          (     
			[User_id],
		  	Cat_id,
			News_title,	
			News_subtitle,
			News_content,
			News_image
          ) 
     VALUES 
          ( 
			@User_id,
			@Cat_id,
			@News_title,	
			@News_subtitle,
			@News_content,
			@News_image
          ) 
END

--Delete news

CREATE PROCEDURE delete_news (
	@News_id int
	)
AS 
BEGIN 
	Delete from Comment
	WHERE News_id = @News_id;
		
	 Delete from News 
     WHERE News_id = @News_id;
END

--UPDATE NEWS
CREATE PROCEDURE update_news (
	@News_id int,
    @Cat_id int,	
	@News_title nvarchar(100),
	@News_subtitle nvarchar(50),
	@News_content nvarchar (MAX),
	@News_image varchar(30)
	)
AS 
BEGIN 

	UPDATE News
	SET Cat_id = @Cat_id,
		News_title = @News_title,
		News_subtitle = @News_subtitle,
		News_content = @News_content,
		News_image = @News_image
	WHERE News_id = @News_id
END

--INSERTING COMMENTS
CREATE PROCEDURE insert_comments (
	@News_id int,
	@User_id int,
	@Comment_content nvarchar(MAX)
	)
AS 
BEGIN 

	INSERT INTO Comment
          (     
			News_id,
			[User_id],
			Comment_content
          ) 
     VALUES 
          ( 
			@News_id,
			@User_id,
			@Comment_content
          ) 

END


--delete comments procedure
CREATE PROCEDURE delete_comments (
	@Comment_id int
	)
AS 
BEGIN 

	 Delete from Comment 
     WHERE Comment_id = @Comment_id;
END


--update comments
CREATE PROCEDURE update_comments (
	@Comment_id int,
	@Comment_content nvarchar(MAX)
	)
AS 
BEGIN 
		UPDATE Comment
		SET Comment_content = @Comment_content
		WHERE Comment_id = @Comment_id	
END


--Insert save
CREATE PROCEDURE insert_save (
	@News_id int,
	@User_id int
	)
AS 
BEGIN 

	INSERT INTO [Save]
          (     
		   [User_id],
		   News_id
          ) 
     VALUES 
          ( 
			@News_id,
			@User_id
          ) 

END

--delete save procedure

CREATE PROCEDURE delete_save (
	@Save_id int
	)
AS 
BEGIN 
	 Delete from [Save] 
     WHERE Save_id = @Save_id;
END


--get save news
SELECT *
FROM News n,Category c, [Save] s
WHERE n.Cat_id = c.Cat_id 
	AND s.[User_id] = 2
	AND n.News_id = s.News_id;


--RESET EVERYTHING IN DATABSE
CREATE PROCEDURE reset_database

AS
BEGIN

	DROP TABLE [Save]
	DROP TABLE Comment
	DROP TABLE News
	DROP TABLE Category
	DROP TABLE UserS



	CREATE TABLE UserS(
	[User_id] INT IDENTITY(1,1) PRIMARY KEY,
	[User_name] NVARCHAR(50),
	Gender NVARCHAR(20),
	dob DATE,
	Username VARCHAR(60),
	id_Admin bit,
	PASSWORD VARCHAR(20)
	);


	CREATE TABLE Category(
	Cat_id int IDENTITY(1,1) PRIMARY KEY,
	Cat_name nvarchar(50),
	Cat_description nvarchar(100)
	);

	CREATE TABLE News (
	News_id int IDENTITY(1,1) Primary Key,
	[User_id] int FOREIGN KEY REFERENCES UserS([User_id]),
	Cat_id int FOREIGN KEY REFERENCES Category(Cat_id),
	News_title nvarchar(100),
	News_subtitle nvarchar(200),
	News_content nvarchar(MAX),
	News_image varchar(50)
	);


	CREATE TABLE Comment(
	Comment_id int IDENTITY(1,1) PRIMARY KEY,
	[User_id] int FOREIGN KEY REFERENCES UserS([User_id]),
	News_id int FOREIGN KEY REFERENCES News(News_id),
	Comment_content nvarchar(MAX)
	);

	CREATE TABLE [Save] (
	Save_id int IDENTITY(1,1) PRIMARY KEY,
	[User_id] int FOREIGN KEY REFERENCES UserS([User_id]),
	News_id int FOREIGN KEY REFERENCES News(News_id),
	)

END

/*USE NewWebsite1
EXECUTE dbo.reset_database

INSERT INTO UserS
VALUES ('Hung','Alpache Helicopter','2003-05-01','hungtt',1,'123')

INSERT INTO Category
VALUES      ('Education',
             'Math');


SELECT IDENT_CURRENT ('News') AS latest_id ;

SELECT
  CASE
    WHEN (SELECT
        COUNT(1)
      FROM  News) = 0 THEN 1
    ELSE IDENT_CURRENT('News') + 1
  END AS Current_Identity;

  select * from News* /

