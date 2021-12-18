$('.comment-text').on('keyup', function() {
    $('.comment_cnt').html($(this).val().length+" / 300");

    if($(this).val().length > 300) {
        $(this).val($(this).val().substring(0, 300));
        $('.comment_cnt').html("300 / 300");
    }
});

$('.comment-text2').on('keyup', function() {
    $('.comment_cnt2').html($(this).val().length+" / 300");

    if($(this).val().length > 300) {
        $(this).val($(this).val().substring(0, 300));
        $('.comment_cnt2').html("300 / 300");
    }
});

$('.upload-input-textarea').on('keyup', function() {
    $('.uplaod_cnt').html($(this).val().length+" / 4000");

    if($(this).val().length > 4000) {
        $(this).val($(this).val().substring(0, 4000));
        $('.uplaod_cnt').html("4000 / 4000");
    }
});

const commentBtn = document.querySelector('.comment-view-btn');
const commentViews = document.querySelectorAll('.comment-view');
commentBtn.addEventListener('click', () =>{
	for( var i = 0; i < commentViews.length; i++ ){
		var item = commentViews.item(i);
		item.classList.toggle('active');
	}
});

function addEvent(btn, box) {
	btn.addEventListener('click', () =>{
		box.classList.toggle('active')
	});
}

const commentReplyBtns = document.querySelectorAll('.comment-comment-btn');
const commentReplyTxts = document.querySelectorAll('.comment-reply2');
for(var i = 0 ; i < commentReplyBtns.length ; i++){
	const commentReplyBtn = commentReplyBtns[i];
	const commentReplyTxt = commentReplyTxts[i];
	addEvent(commentReplyBtn, commentReplyTxt);
}


const toggleBtn = document.querySelector('.navbar-toggleBtn');
const menu = document.querySelector('.navbar-menu');
const login = document.querySelector('.navbar-login');
active(toggleBtn, menu, login);

function active(btn,item1,item2) {
	btn.addEventListener('click', () =>{
		item1.classList.toggle('active');
		item2.classList.toggle('active');
	});
}