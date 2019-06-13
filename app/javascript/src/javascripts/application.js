$(function() {
  // ハンバーメニュー
  $(".nav-toggle").click(function() {
    $("#tab-menu").toggleClass("nav-open");
  });

  // 検索ページ遷移
  $("#sp-serch").click(function() {
    $("#serch-page").show();
  });

  $("#serch-page-close").click(function() {
    $("#serch-page").hide();
  });
});
