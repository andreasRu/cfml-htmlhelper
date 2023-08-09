component displayname = "Application" output = "false" hint = "Handle the application" {

	this.charset.web = "UTF-8";
	this.charset.resource = "UTF-8";

	//function is fired at start of request
	public boolean function onRequestStart() output=false {
        
		request.ExecStart = GetTickCount();
        return true;

	}

}
