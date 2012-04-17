function showPoints()
{
    $('differentPoints').hide();
    $('firstPoints').show();
    $('secondPoints').show();
}
function showDifferent()
{
    $('firstPoints').hide();
    $('secondPoints').hide();
    $('differentPoints').show();
}

function showPaymentDetails()
{
    $('paymentDetails').show();
}
function hidePaymentDetails()
{
    $('paymentDetails').hide();
}

function updateSubTypeDiv()
{
    var selectedValue = document.getElementById("type").value;
    switch (selectedValue)
    {
        case "COUNT":
            showPoints();
            break;
        case "RANGE":
            showDifferent();
            break;
    }
}

function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

function updatePaymentType(radioObj)
{
    var selectedValue = getCheckedValue(radioObj);
    switch (selectedValue)
    {
        case "13":
            hidePaymentDetails();
            break;
        default:
            showPaymentDetails();
            break;
    }
}

window.onload = function()
{
    updateSubTypeDiv()
}