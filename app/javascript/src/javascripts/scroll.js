$(function() {
  let windowWidth = window.innerWidth; //ウィンドウサイズ
  const breakPoint = 1120;

  let topPosition, nowPosition;
  $(window).scroll(function() {
    topPosition = $(window).scrollTop(); // スクロールトップポジションを取得
  });

  // 投稿モーダル 表示
  $("#modal-checkbox--post").change(function() {
    if (windowWidth >= breakPoint) {
      nowPosition = topPosition; //クリック時の位置取得
      $("#modal-content--post").css("top", nowPosition + 50);
      $("#modal-close--post").css("top", nowPosition);
    } else {
      nowPosition = topPosition; //クリック時の位置取得
      $("#modal-close--post, #modal-content--post").css("top", nowPosition);
      $("main").hide();
    }
    $("body").toggleClass("active");
    if ($(this).prop("checked") == true) {
      $("#modal-content--post").fadeIn();
    } else {
      $("#modal-content--post").fadeOut("fast");
    }
  });
});
