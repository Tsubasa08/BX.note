$(function() {
  $(window).scroll(function() {
    // スクロールトップポジション
    const scrolleHeight = $(window).scrollTop();
    const togglePosition = 250;

    // ---------- トップに戻るボタン ----------
    // ----- ボタン表示/非表示 -----
    if (scrolleHeight < togglePosition) {
      // 非表示
      $("#toTop").fadeOut();
    } else {
      // 表示
      $("#toTop").fadeIn();
    }
  });

  // ----- トップへスクロール -----
  $("#toTop").click(function() {
    $("html, body").animate(
      {
        scrollTop: 0
      },
      500
    );
  });
});
