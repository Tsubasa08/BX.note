$(function() {
  let windowWidth = window.innerWidth; //ウィンドウサイズ
  const breakPoint = 1120;

  $(window).scroll(function() {
    const scrolleHeight = $(window).scrollTop(); // スクロールトップポジションを取得
    if (windowWidth >= breakPoint) {
      $("#modal-content--post").css("top", scrolleHeight + 50);
      $("#modal-close--post").css("top", scrolleHeight);
    } else {
      $("#modal-close--post, #modal-content--post").css("top", scrolleHeight);
    }
  });
});
