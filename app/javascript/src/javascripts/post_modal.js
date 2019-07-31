$(function() {
  //ウィンドウサイズ
  let windowWidth = window.innerWidth;
  const breakPoint = 1120;

  let topPosition, nowPosition;
  $(window).scroll(function() {
    // トップポジション
    topPosition = $(window).scrollTop();
  });

  // ---------- 投稿フォームモーダル ----------
  // ----- 表示 -----
  $("#modal-open").click(function() {
    $("body, #modal-open").addClass("active");
    nowPosition = topPosition; //クリック時の位置取得
    const topGap = 50;
    if (windowWidth >= breakPoint) {
      //PCサイズ
      $("#modal-content--post")
        .fadeIn()
        .css("top", nowPosition + topGap);
      $("#modal-close--post")
        .fadeIn()
        .css("top", nowPosition);
    } else {
      //Tabサイズ以下
      $("#modal-content--post")
        .fadeIn()
        .css("top", 0);
      $("#close-btn--tab").show();
      $("header, main, footer").hide();
    }
  });

  // ----- 非表示 -----
  const closeFormModalMethod = function() {
    $("#modal-content--post, #modal-close--post").fadeOut("fast");
    $("body, #modal-open").removeClass("active");
    $("#panel-area .panel").remove();
    $("header, main, footer").show();
    $(window).scrollTop(nowPosition); //クリック時の位置
  };

  const closeFormModal = function() {
    if ($("#panel-area").hasClass("active")) {
      if (window.confirm("投稿を破棄しますか？")) {
        closeFormModalMethod();
        $("#panel-area").toggleClass("active");
        setTimeout(function() {
          $("#label-area").toggleClass("active");
        }, 1000);
      }
    } else {
      closeFormModalMethod();
    }
  };

  // closeボタンクリック(PC：バツボタン TAB以下：キャンセルボタン)
  $(".close-btn").click(function() {
    closeFormModal();
  });

  //モーダル外をクリック
  $(document).on("click touchend", function(event) {
    if ($("#modal-open").hasClass("active")) {
      if (
        !$(event.target).closest("#modal-content--post, #modal-open").length
      ) {
        closeFormModal();
      }
    }
  });

  // ----- パネル切り替え -----
  $(".label").click(function() {
    $("#label-area, #panel-area").toggleClass("active");
    $("#prev-btn").fadeIn();
    if (windowWidth < breakPoint) {
      $("#close-btn--tab, .dummy-submit-btn").fadeToggle();
    }
  });

  // ----- ジャンル選択画面に戻る -----
  $("#prev-btn").click(function() {
    if (window.confirm("投稿を破棄しますか？")) {
      $("#label-area, #panel-area").toggleClass("active");
      $(this).fadeOut();
      if (windowWidth < breakPoint) {
        $("#close-btn--tab, .dummy-submit-btn").fadeToggle();
        $(".dummy-submit-btn").attr("id", "");
      }
      // フォームリセット
      $(".form--post")[0].reset();
    }
  });

  // ---------- 投稿詳細・編集モーダル ----------
  // ------ 表示 ------
  $(".post-list").on("click", ".post-show-link, .post-edit", function() {
    nowPosition = topPosition; //クリック時の位置取得
    $("body, #modal-content--post-show, #modal-close--post-show").addClass(
      "active"
    );
    if (windowWidth < breakPoint) {
      $("header, main, footer").hide();
    }
  });

  // ------ 非表示 ------
  // 投稿詳細
  const closeShowModal = function() {
    if ($("#modal-close--post-show").hasClass("active")) {
      $("#modal-content--post-show .inner").remove();
      $("body, #modal-content--post-show, #modal-close--post-show").removeClass(
        "active"
      );
      if (windowWidth < breakPoint) {
        $("header, main, footer").show();
        $(window).scrollTop(nowPosition); //クリック時の位置
      }
    }
  };

  // 投稿編集
  const closeEditmModal = function() {
    if (window.confirm("編集内容を破棄しますか？")) {
      closeShowModal();
      $("#modal-close--post-show").removeClass("edit-active");
    }
  };

  // PCサイズ
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#modal-content--post-show").length) {
      if ($("#modal-close--post-show").hasClass("edit-active")) {
        closeEditmModal();
      } else {
        closeShowModal();
      }
    }
  });

  // TABサイズ以下
  $("#modal-content--post-show").on("click", ".close-btn", function() {
    if ($("#modal-close--post-show").hasClass("edit-active")) {
      closeEditmModal();
    } else {
      closeShowModal();
    }
  });
});
