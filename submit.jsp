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
</style>
<body><div class="containerhead">
   <div class="header1"><h1>Term End Examination</h1></div>
   <div class="header2">&emsp;&emsp;
   <a href="home.jsp">Home</a>&emsp;&emsp;
   <a href="feedback.jsp">Feedback</a></div>
 </div>


<div class="container">

       
        <div class="right">
        
        <h2>Form Submitted</h2>
        <p>Thank you, <%= request.getParameter("name") %>. Your feedback has been recorded.
        your feedback is "<%= request.getParameter("feedback") %>"</p>
        </div>
        
</div>


</body>
</html>