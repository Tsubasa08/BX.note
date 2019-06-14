$(function() {
  // ハンバーメニュー
  $(".nav-toggle").click(function() {
    $("#tab-menu").toggleClass("nav-open");
    $("html, body").toggleClass("active");
  });

  // tab-menu contents --vhというカスタムプロパティを作成
  let vh = window.innerHeight * 0.01;
  document.documentElement.style.setProperty("--vh", `${vh}px`);
  // window resize
  window.addEventListener("resize", () => {
    vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty("--vh", `${vh}px`);
  });

  // 検索ページ遷移
  $("#sp-serch").click(function() {
    $("#serch-page").show();
  });

  $("#serch-page-close").click(function() {
    $("#serch-page").hide();
  });
});
