$(function() {
  // ハンバーメニュー
  $(".nav-toggle").click(function() {
    $("body").toggleClass("nav-open");
  });

  // 検索ページ遷移
  $("#sp-serch").click(function() {
    $("#serch-page").show();
  });

  $("#serch-page-close").click(function() {
    $("#serch-page").hide();
  });
});
