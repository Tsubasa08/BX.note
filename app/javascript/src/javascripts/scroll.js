$(function() {
  $(window).scroll(function() {
    const scrolleHeight = $(window).scrollTop(); // スクロールトップポジションを取得

    // ---------- トップに戻るボタン ----------
    if (scrolleHeight < 250) {
      $("#toTop").fadeOut(); //トップに戻るボタン_非表示
    } else {
      $("#toTop").fadeIn(); //トップに戻るボタン_表示
    }
  });

  $("#toTop").click(function() {
    $("html, body").animate(
      {
        scrollTop: 0
      },
      500
    );
  });
});
