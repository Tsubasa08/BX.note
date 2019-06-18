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

  // 画像アップロード レイアウト遷移
  $("#user_image").on("change", function() {
    let file = $(this).prop("files")[0];
    if (!$(".filename").length) {
      $("#form-image").append('<span class="filename"></span>');
    }
    $("#input-label").addClass("changed");
    $(".filename").html(file.name);
  });

  // 画像警告
  $("#user_image").bind("change", function() {
    let size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
      alert("画像サイズは5MB以内にしてくだい");
    }
  });
});
