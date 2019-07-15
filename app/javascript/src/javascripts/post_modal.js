$(function() {
  let windowWidth = window.innerWidth; //ウィンドウサイズ
  const breakPoint = 1120;

  let topPosition, nowPosition;
  $(window).scroll(function() {
    topPosition = $(window).scrollTop(); // スクロールトップポジションを取得
  });

  // 投稿モーダル 開く
  $("#modal-open").click(function() {
    nowPosition = topPosition; //クリック時の位置取得
    $("body").toggleClass("active");
    if (windowWidth >= breakPoint) {
      //PC
      $("#modal-content--post, #modal-close--post").fadeIn();
      $("#modal-content--post").css("top", nowPosition + 50);
      $("#modal-close--post").css("top", nowPosition);
      $("#modal-close--post").addClass("active");
    } else {
      //Tab以下
      $("#modal-content--post").fadeIn();
      $("#modal-close--post, #modal-content--post").css("top", 0);
      $("main, footer").hide();
    }
  });

  // -- 投稿モーダル 閉じる --
  const closeModal = function() {
    $("#modal-content--post, #modal-close--post").fadeOut("fast");
    $("body").removeClass("active");
    if (windowWidth < breakPoint) {
      $("main, footer").show();
    }
    $(window).scrollTop(nowPosition); //クリック時の位置
  };

  $(".close-btn").click(function() {
    closeModal();
  });
  //モーダル外をクリック
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#modal-content--post, #modal-open").length) {
      closeModal();
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

  //テスト
  $("#panel-area").on("click", "#book-serch", function() {
    $("#book-list").remove();
    $("#loading-wrapper").show();
  });
});
