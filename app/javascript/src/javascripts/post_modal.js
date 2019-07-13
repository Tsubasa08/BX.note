$(function() {
  let windowWidth = window.innerWidth; //ウィンドウサイズ
  const breakPoint = 1120;

  // 投稿モーダル 表示
  $("#modal-checkbox--post").change(function() {
    $("body").toggleClass("active");
    if ($(this).prop("checked") == true) {
      $("#modal-content--post").fadeIn();
    } else {
      $("#modal-content--post").fadeOut("fast");
    }
  });

  // 投稿モーダル パネル切り替え
  $(".label").click(function() {
    var $th = $(this).index();
    $(".label").removeClass("active");
    $(".panel").removeClass("active");
    $(this).addClass("active");
    $(".panel")
      .eq($th)
      .addClass("active");
    $("#label-area, #panel-area").toggleClass("active");
    $("#prev-btn").fadeIn();

    $("#close-btn--tab").fadeOut();
    if (windowWidth < breakPoint) {
      $("#dummy-submit-btn").fadeIn();
    }
  });
  $("#prev-btn").click(function() {
    $("#label-area, #panel-area").toggleClass("active");
    $(this).fadeOut();
    $("#close-btn--tab").fadeIn();
    if (windowWidth < breakPoint) {
      $("#dummy-submit-btn").fadeOut();
    }

    $(".form--post")[0].reset();
  });

  // ダミーsubmitボタン
  $("#modal-header").on("click", "#dummy-submit-btn", function() {
    $("#form-post").submit();
  });

  // カテゴリープルダウンメニュー
  if (windowWidth < breakPoint) {
    $("#panel-area").on("click", "#check-block-title", function() {
      $("#category-list").slideToggle();
      $(this).toggleClass("active");
    });
  }
});
