<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
    <link rel="stylesheet" href="styles.css">
</head>
<style>
* {
    box-sizing: border-box;
}
.header1{
    background-color: yellow;
    width: 50%;
    display: flex;
    text-align: center;
    justify-content: center; 
  
}
.header2{
    background-color: pink;
    width: 50%;
    display: flex;
    text-align: center;
    justify-content: center; 
  
}
.container{
    display: flex;
    text-align: center;
    height: 100vh;
 
    display: flex;
    justify-content: center; /* Centers content horizontally */
    
    
}
.containerhead{
   display: flex;
 
   width: 100%;
    
  
}

.right{
    width: 100%;
     background-color: #5cdb35;
     justify-content: center;
}
table{
     text-align: center;
     border-collapse: collapse;
     margin-top: 30px;
     margin-left: 20%;
     font-size: 20px;
}

a{
    margin-top: 25px;
}
.form{
    width: 60%;
    height: 40vh;
    margin-top: 30px;
    margin-left: auto;
    margin-right: auto; /* Center horizontally */
    font-size: 20px;
    background-color: white;
    border-radius: 10px; /* Rounded corners */
    box-shadow: 0px 4px 8px rgba(0.1, 0, 0.1, 0.3); /* Shadow effect */
    padding: 20px; /* Space inside the form */
    
    flex-direction: column;
    gap: 15px; /* Space between elements */
}
.feedback {
    height: 100px; /* Larger height for feedback input */
    resize: vertical; /* Allow resizing vertically */
}
</style>
<body><div class="containerhead">
   <div class="header1"><h1>Term End Examination</h1></div>
   <div class="header2">&emsp;&emsp;
   <a href="home.jsp">Home</a>&emsp;&emsp;
   <a href="feedback.jsp">Feedback</a></div>
 </div>


<div class="container">

       
        <div class="right">
        <div class="form">
       <form action="submit.jsp" method="post">
       <label>Name:- </label>
       <input type="text" name="name" placeholder="Enter Name" required><br><br>
       <label>Programme :- </label>
       <label name="bca">BCA </label><input type="radio" name="1" value="bca"><br>
        <label name="bca">MCA </label><input type="radio" name="1" value="mca"><br>
        <label>What is your Feedback ? </label>
        <input type="text" name="feedback" placeholder="Enter your feedback" size ="50"  required></br>
        <button type="submit">Submit</button>

        </div>
        
</div>


</body>
</html>