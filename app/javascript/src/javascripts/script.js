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
    const data = $(this).data("id");
    const file = $(this).prop("files");
    $(`.filename--${data}`).hide();
    Array.from(file).forEach(e => {
      $(`#form-image--${data}`).append(
        `<span class="filename filename--${data}">${e.name}</span>`
      );
      $(`#input-label--${data}`).addClass("changed");
    });
  });

  // 画像警告
  $("#user_image").bind("change", function() {
    let size = this.files[0].size / 1024 / 1024;
    if (size > 5) {
      alert("画像サイズは5MB以内にしてくだい");
    }
  });

  // ページ上部メッセージ
  setTimeout(function() {
    $("#alert").addClass("alert-down");
  }, 100);
  setTimeout(function() {
    $("#alert").removeClass("alert-down");
  }, 2500);
});
