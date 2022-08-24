function checkEurope() {
    if(document.getElementById("europe").checked){
        document.getElementById("africa").checked = false;
        document.getElementById("asia").checked = false;
        document.getElementById("america").checked = false;
        document.getElementById("oceania").checked = false;
    }
}

function checkAfrica() {
    if(document.getElementById("africa").checked){
        document.getElementById("europe").checked = false;
        document.getElementById("asia").checked = false;
        document.getElementById("america").checked = false;
        document.getElementById("oceania").checked = false;
    }
}

function checkAsia() {
    if(document.getElementById("asia").checked){
        document.getElementById("africa").checked = false;
        document.getElementById("europe").checked = false;
        document.getElementById("america").checked = false;
        document.getElementById("oceania").checked = false;
    }
}

function checkAmerica() {
    if(document.getElementById("america").checked){
        document.getElementById("africa").checked = false;
        document.getElementById("asia").checked = false;
        document.getElementById("europe").checked = false;
        document.getElementById("oceania").checked = false;
    }
}

function checkOceania() {
    if(document.getElementById("oceania").checked){
        document.getElementById("africa").checked = false;
        document.getElementById("asia").checked = false;
        document.getElementById("america").checked = false;
        document.getElementById("europe").checked = false;
    }
}

//company functions

function checkFamily() {
    if(document.getElementById("family").checked){
    	document.getElementById("romantic").checked = false;
        document.getElementById("alone").checked = false;
        document.getElementById("friends").checked = false;
        document.getElementById("people").checked = false;
    }
}

function checkLove() {
    if(document.getElementById("romantic").checked){
    	document.getElementById("family").checked = false;
        document.getElementById("alone").checked = false;
        document.getElementById("friends").checked = false;
        document.getElementById("people").checked = false;
    }
}

function checkAlone() {
    if(document.getElementById("alone").checked){
    	document.getElementById("romantic").checked = false;
        document.getElementById("family").checked = false;
        document.getElementById("friends").checked = false;
        document.getElementById("people").checked = false;
    }
}

function checkFriends() {
    if(document.getElementById("friends").checked){
    	document.getElementById("romantic").checked = false;
        document.getElementById("alone").checked = false;
        document.getElementById("familys").checked = false;
        document.getElementById("people").checked = false;
    }
}

function checkPeople() {
    if(document.getElementById("people").checked){
    	document.getElementById("romantic").checked = false;
        document.getElementById("alone").checked = false;
        document.getElementById("friends").checked = false;
        document.getElementById("family").checked = false;
    }
}