function active(btn,item1,item2) {
	btn.addEventListener('click', () =>{
		item1.classList.toggle('active');
		item2.classList.toggle('active');
	});
}

$('.input-box-input').each(function(){
	$(this).on('blur', function(){
		if($(this).val().trim() != "") {
			$(this).addClass('has-val');
		}
		else {
			$(this).removeClass('has-val');
		}
	})    
})

var showPass = 0;
$('.btn-show').on('click', function(){
	if(showPass == 0) {
		$(this).next('input').attr('type','text');
		$(this).find('i').removeClass('fa-eye');
		$(this).find('i').addClass('fa-eye-slash');
		showPass = 1;
	}
	else {
		$(this).next('input').attr('type','password');
		$(this).find('i').addClass('fa-eye');
		$(this).find('i').removeClass('fa-eye-slash');
		showPass = 0;
	}
});

const toggleBtn = document.querySelector('.navbar-toggleBtn');
const menu = document.querySelector('.navbar-menu');
const login = document.querySelector('.navbar-login');
active(toggleBtn, menu, login);


const toggleBtn2 = document.querySelector('.toggleBtn2');
const loginForm = document.querySelector('.login-form');
const signForm = document.querySelector('.SignUp-form');
active(toggleBtn2, loginForm, signForm);


const toggleBtn3 = document.querySelector('.toggleBtn3');
const loginForm2 = document.querySelector('.login-form');
const signForm2 = document.querySelector('.SignUp-form');
active(toggleBtn3, loginForm2, signForm2);

