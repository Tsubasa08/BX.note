$(function() {
  // ハンバーメニュー
  $(".nav-toggle").click(function() {
    $("#tab-menu").toggleClass("nav-open");
    // $("html").toggleClass("active");

    if ($("#tab-menu-contents").hasClass("active")) {
      $("#tab-menu-contents").fadeOut(100);
      $("#tab-menu-contents").removeClass("active");
    } else {
      setTimeout(function() {
        $("#tab-menu-contents").fadeIn(500);
      }, 150);
      $("#tab-menu-contents").addClass("active");
    }
  });

  // tab-menu contents --vhというカスタムプロパティを作成
  // let vh = window.innerHeight * 0.01;
  // document.documentElement.style.setProperty("--vh", `${vh}px`);
  // // window resize
  // window.addEventListener("resize", () => {
  //   vh = window.innerHeight * 0.01;
  //   document.documentElement.style.setProperty("--vh", `${vh}px`);
  // });

  // ユーザーリンク表示
  $("#user-icon").click(function() {
    $("#user-link").toggle();
  });
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#user-icon").length) {
      $(this)
        .find("#user-link")
        .hide();
    }
  });

  // 検索ページ遷移
  $("#sp-serch").click(function() {
    $("#serch-page").show();
  });

  $("#serch-page-close").click(function() {
    $("#serch-page").hide();
  });

  // 投稿詳細 表示
  $(".comment-link").on("click", ".post-show-link", function() {
    $("body, #modal-close--post-show").addClass("active");
    setTimeout(function() {
      $("#modal-content--post-show").fadeIn();
    }, 200);
  });
  // 投稿詳細 非表示
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#modal-content--post-show").length) {
      $("#modal-content--post-show").fadeOut("fast");
      $("body, #modal-close--post-show").removeClass("active");
      $("#content-remove-check").prop("checked", true);
    }
  });

  // 投稿モーダル 表示
  $("#modal-checkbox--post").click(function() {
    if ($(this).prop("checked") == true) {
      $("body").addClass("active");
      $("#modal-content--post").fadeIn();
    } else {
      $("body").removeClass("active");
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
  });
  $("#prev-btn").click(function() {
    $("#label-area, #panel-area").toggleClass("active");
    $(this).fadeOut();
    $("#close-btn--tab").fadeIn();
    $(".form--post")[0].reset();
  });

  // 画像アップロード レイアウト遷移
  $(".image-form").on("change", function() {
    let over; // Filelist
    const data = $(this).data("id");
    const file = $(this).prop("files");
    $(`.filename--${data}`).hide();
    Array.from(file).forEach(e => {
      const size = e.size / 1024 / 1024; // ファイルサイズ
      if (size > 5) {
        over = "true";
        over_name = e.name;
        $(`.filename--${data}`).hide();
      } else {
        over = "false";
        // 選択したファイル名を表示
        $(`#form-image--${data}`).append(
          `<span class="filename filename--${data}">${e.name}</span>`
        );
        $(`#input-label--${data}`).addClass("changed");
      }
    });
    if (over == "true") {
      alert(`画像サイズは5MB以内にしてくだい(${over_name}`);
    }
    // overをリセット
    over = "";
  });

  // ページ上部メッセージ
  setTimeout(function() {
    $("#alert").addClass("alert-down");
  }, 100);
  setTimeout(function() {
    $("#alert").removeClass("alert-down");
  }, 2500);

  // introduce文字制限 77文字以上に３点リーダー
  $(".introduce-text").each(function(i, t) {
    let count = $(t).text().length;
    if (count > 76) {
      $(this).addClass("active");
    }
  });

  // 投稿検索結果 一致する結果なし
  let posts = $(".post-list").children();
  if (posts.length === 0) {
    let title = $("#search-title").text();
    $(".post-list").append(
      `<p class="failure-text">「${title}」に一致する検索結果はありません</p>`
    );
  }
});
