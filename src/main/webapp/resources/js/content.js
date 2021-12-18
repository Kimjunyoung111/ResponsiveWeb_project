function active(btn,item1,item2) {
	btn.addEventListener('click', () =>{
		item1.classList.toggle('active');
		item2.classList.toggle('active');
	});
}

function active2(btn,item1,item2,item3,item4,item5) {
	btn.addEventListener('click', () =>{
		item1.classList.toggle('active');
		item2.classList.toggle('active');
		item3.classList.toggle('active');
		item4.classList.toggle('active');
		item5.classList.toggle('active');
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


const categoryCur = document.querySelector('.category.categoryCur');
const categoryAll = document.querySelector('#ALL');
const categoryCategory1 = document.querySelector('#category1');
const categoryCategory2 = document.querySelector('#category2');
const categoryCategory3 = document.querySelector('#category3');
const categoryCategory4 = document.querySelector('#category4');
active2(categoryCur, categoryAll,categoryCategory1,categoryCategory2,
		categoryCategory3,categoryCategory4);


