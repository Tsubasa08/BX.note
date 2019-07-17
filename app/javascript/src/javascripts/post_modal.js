$(function() {
  //ウィンドウサイズ
  let windowWidth = window.innerWidth;
  const breakPoint = 1120;

  let topPosition, nowPosition;
  $(window).scroll(function() {
    // スクロールトップポジション
    topPosition = $(window).scrollTop();
  });

  // ---------- 投稿フォームモーダル ----------
  // ----- 投稿フォームモーダル 表示 -----
  $("#modal-open").click(function() {
    $("body, #modal-open").addClass("active");
    nowPosition = topPosition; //クリック時の位置取得
    if (windowWidth >= breakPoint) {
      //PCサイズ
      $("#modal-content--post")
        .fadeIn()
        .css("top", nowPosition + 50);
      $("#modal-close--post")
        .fadeIn()
        .css("top", nowPosition);
    } else {
      //Tabサイズ以下
      $("#modal-content--post")
        .fadeIn()
        .css("top", 0);
      $("header, main, footer").hide();
    }
  });

  // ----- 投稿フォームモーダル 非表示 -----
  const closeFormModal = function() {
    $("#modal-content--post, #modal-close--post").fadeOut("fast");
    $("body, #modal-open").removeClass("active");
    $("header, main, footer").show();
    $(window).scrollTop(nowPosition); //クリック時の位置
  };

  // closeボタンクリック(PC：バツボタン TAB以下：キャンセルボタン)
  $(".close-btn").click(function() {
    closeFormModal();
  });
  //投稿フォームモーダル外をクリック
  $(document).on("click touchend", function(event) {
    if ($("#modal-open").hasClass("active")) {
      if (
        !$(event.target).closest("#modal-content--post, #modal-open").length
      ) {
        closeFormModal();
      }
    }
  });

  // 投稿フォームモーダル パネル切り替え
  $(".label").click(function() {
    $("#label-area, #panel-area").toggleClass("active");
    $("#prev-btn").fadeIn();
    if (windowWidth < breakPoint) {
      $("#close-btn--tab, #dummy-submit-btn").fadeToggle();
    }
  });
  // ジャンル選択画面に戻る
  $("#prev-btn").click(function() {
    $("#label-area, #panel-area").toggleClass("active");
    $(this).fadeOut();
    if (windowWidth < breakPoint) {
      $("#close-btn--tab, #dummy-submit-btn").fadeToggle();
    }
    // フォームリセット
    $(".form--post")[0].reset();
  });

  // ダミーsubmitボタン(TABサイズ以下)
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

  //本検索ローディング処理中アイコン
  $("#panel-area").on("click", "#book-serch", function() {
    $("#book-list").remove();
    $("#loading-wrapper").show();
  });

  // ---------- 投稿詳細モーダル ----------
  // ------ 投稿詳細モーダル 表示 ------
  $(".post-list__item").on("click", ".post-show-link, .post-edit", function() {
    nowPosition = topPosition; //クリック時の位置取得
    $("body, #modal-close--post-show").addClass("active");
    if (windowWidth < breakPoint) {
      $("header, main, footer").hide();
    }
  });

  // ------ 投稿詳細モーダル 非表示 ------
  const closeShowModal = function() {
    if ($("#modal-close--post-show").hasClass("active")) {
      $("#modal-content--post-show .inner").remove();
      $("body, #modal-close--post-show").removeClass("active");
      if (windowWidth < breakPoint) {
        $("header, main, footer").show();
        $(window).scrollTop(nowPosition); //クリック時の位置
      }
    }
  };
  // PCサイズ
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#modal-content--post-show").length) {
      closeShowModal();
    }
  });

  // TABサイズ以下
  $(document).on("click", "#show-header__close", function() {
    closeShowModal();
  });
});
