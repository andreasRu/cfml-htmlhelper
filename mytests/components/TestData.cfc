component output=false {

	public function init() {
```
<cfprocessingdirective pageEncoding="UTF-8">
<cfsavecontent variable="this.fullHTML"><!DOCTYPE html>
	<head>
	<title>Hot CFML Page & content</title>
				<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style> /* some comment 
	*/ 
	.someClass{ 
	font-size: 1rem; /* set font size */        } </style>
																				
																									
																									
	<meta name="description" content="Just some Example">
	<link rel="stylesheet" href="css/main.css">
		</head> <body>
	<!--     Say "Hello" to the CFML coders! --> <p>Hello to all CFML devs 😀 🤩 around the 🌎!!! </p>
	<script>    /*    this is just some 
	embedded JavaScript          */
	
	/* this is just some embedded JavaScript */   
	
	console.log('Log Something'); // 1. this is just a trailing comment one Javascript
	console.log('Log Something else'); // 2. this is another trailing comment with a trailing double// 
	/* this is just some embedded JavaScript 
	*//* test */  
	/* this is just some embedded JavaScript */  
	/* this is just some embedded JavaScript */  
	
	// 3. a third javascript comment beginning at the line; 
	// 4. a fourth javascript comment in the middle; 
	// 5. and some more comment with another outcommented Javascript // 6. console.log('this shouldn't show!'); 
	 console.log('Log final');  
	 
	 </script>        </body> </html>
</cfsavecontent>



<cfsavecontent variable="this.FullResult"><!DOCTYPE html>
	<head>
	<title>Hot CFML Page & content</title>
				<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style> /* some comment 
	*/ 
	.someClass{ 
	font-size: 1rem; /* set font size */        } </style>
																				
																									
																									
	<meta name="description" content="Just some Example">
	<link rel="stylesheet" href="css/main.css">
		</head> <body>
	<!--     Say "Hello" to the CFML coders! --> <p>Hello to all CFML devs 😀 🤩 around the 🌎!!! </p>
	<script>    /*    this is just some 
	embedded JavaScript          */
	
	/* this is just some embedded JavaScript */   
	
	console.log('Log Something'); // 1. this is just a trailing comment one Javascript
	console.log('Log Something else'); // 2. this is another trailing comment with a trailing double// 
	/* this is just some embedded JavaScript 
	*//* test */  
	/* this is just some embedded JavaScript */  
	/* this is just some embedded JavaScript */  
	
	// 3. a third javascript comment beginning at the line; 
	// 4. a fourth javascript comment in the middle; 
	// 5. and some more comment with another outcommented Javascript // 6. console.log('this shouldn't show!'); 
	 console.log('Log final');  
	 
	 </script>        </body> </html></cfsavecontent>



<cfsavecontent variable="this.compressWhitespacesResult"><!DOCTYPE html> <head> <title>Hot CFML Page & content</title> <meta charset="utf-8"> <meta http-equiv="X-UA-Compatible" content="IE=edge"> <meta name="viewport" content="width=device-width, initial-scale=1"> <style> /* some comment */ .someClass{ font-size: 1rem; /* set font size */ } </style> <meta name="description" content="Just some Example"> <link rel="stylesheet" href="css/main.css"> </head> <body> <!-- Say "Hello" to the CFML coders! --> <p>Hello to all CFML devs 😀 🤩 around the 🌎!!! </p> <script> /* this is just some embedded JavaScript */ /* this is just some embedded JavaScript */ console.log('Log Something');/* 1. this is just a trailing comment one Javascript*/ console.log('Log Something else');/* 2. this is another trailing comment with a trailing double// */ /* this is just some embedded JavaScript *//* test */ /* this is just some embedded JavaScript */ /* this is just some embedded JavaScript *//* 3. a third javascript comment beginning at the line; */ /* 4. a fourth javascript comment in the middle; */ /* 5. and some more comment with another outcommented Javascript // 6. console.log('this shouldn't show!'); */ console.log('Log final'); </script> </body> </html></cfsavecontent>



<cfsavecontent variable="this.stripScriptAndCssCommentsResult"><!DOCTYPE html>
	<head>
	<title>Hot CFML Page & content</title>
				<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style>  
	.someClass{ 
	font-size: 1rem;         } </style>
																				
																									
																									
	<meta name="description" content="Just some Example">
	<link rel="stylesheet" href="css/main.css">
		</head> <body>
	<!--     Say "Hello" to the CFML coders! --> <p>Hello to all CFML devs 😀 🤩 around the 🌎!!! </p>
	<script>     
	
	console.log('Log Something');
	console.log('Log Something else');



	 console.log('Log final');  
	 
	 </script>        </body> </html></cfsavecontent>
```

	return this;
	}
}