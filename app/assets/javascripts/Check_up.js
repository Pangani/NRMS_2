

function FormStep(step)
{
	//DIVs holding each step
	var anthropometry = document.getElementById("anthropometry")
	var medical = document.getElementById("medical")
	var nutrition = document.getElementById("nutrition")

	switch(step)
	{
		case 1:
			anthropometry.style.display = "block";
			medical.style.display = "none";
			nutrition.style.display = "none";
			break;

		case 2:
			anthropometry.style.display = "none";
			medical.style.display = "block";
			nutrition.style.display = "none";
			break;

		case 3:
			anthropometry.style.display = "none";
			medical.style.display = "none";
			nutrition.style.display = "block";
			break;
	}
}