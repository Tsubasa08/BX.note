$(function() {
  let windowWidth = window.innerWidth; //ウィンドウサイズ
  const breakPoint = 1120;
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

  // 画像アップロード レイアウト遷移
  $(".image-form").on("change", function() {
    let over; // Filelist
    const data = $(this).data("id");
    const file = $(this).prop("files");
    $(`.filename--${data}`).remove();
    Array.from(file).forEach(e => {
      const size = e.size / 1024 / 1024; // ファイルサイズ
      if (size > 5) {
        over = "true";
        over_name = e.name;
        $(`.filename--${data}`).remove();
      } else {
        over = "false";
        // 選択したファイル名を表示
        $(`#form-image--${data}`).append(
          `<span class="filename filename--${data}">・${e.name}</span>`
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
  let posts = $("#post-list--search").children();
  if (posts.length === 0) {
    let title = $("#search-title").text();
    $("#post-list--search").append(
      `<p class="failure-text">「${title}」に一致する検索結果はありません</p>`
    );
  }

  // 投稿メタリンク
  // $(".post-meta-icon").click(function() {
  $(document).on("click", ".post-meta-icon", function() {
    let dataId = $(this).attr("data-id");
    $(`#post-meta-${dataId}`).show();
  });
  // 非表示
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest(".post-meta-icon, .post-meta").length) {
      $(".post-meta").hide();
    }
  });

  // 投稿画像カルーセル
  $(".post-list .slider").slick({
    dots: true
  });
});
