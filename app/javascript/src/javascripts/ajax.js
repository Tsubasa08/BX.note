$(function() {
  //3ジャンルから選択
  $(".label, .post-edit ").click(function() {
    $.ajax({
      url: "/ajax",
      type: "get",
      dataType: "json"
    })
      .done(function(data) {
        // // 投稿モーダル内 画像アップロード レイアウト遷移
        // $(document).on("change", ".image-form", function() {
        //   let over = []; // Filelist配列
        //   const data = $(this).data("id");
        //   const file = $(this).prop("files");
        //   $(`.filename--${data}`).remove();
        //   if (file.length > 3) {
        //     alert("画像を3枚まで選択してください。");
        //     $(this).val(null);
        //   }
        //   Array.from(file).forEach(e => {
        //     const size = e.size / 1024 / 1024; // ファイルサイズ
        //     if (size > 5) {
        //       over.push("true");
        //       over_name = e.name;
        //       $(`.filename--${data}`).remove();
        //     } else {
        //       over.push("false");
        //       // 選択したファイル名を表示
        //       $(`#form-image--${data}`).append(
        //         `<span class="filename filename--${data}">・${e.name}</span>`
        //       );
        //       $(`#input-label--${data}`).addClass("changed");
        //     }
        //   });
        //   if (over.indexOf("true") >= 0) {
        //     //over配列に"true"が存在する
        //     alert(`画像サイズは5MB以内にしてくだい(${over_name}`);
        //     $(this).val(null);
        //     over = [];
        //   }
        //   // over配列をリセット
        //   over = [];
        // });
      })
      .fail(function() {
        window.alert("読み込みエラー");
      });
  });

  $("#panel-area, #modal-content--post-show").on(
    "click",
    ".book-list__item",
    function() {
      $.ajax({
        url: "/ajax",
        type: "get",
        dataType: "json",
        context: this
      })
        .done(function(data) {
          let element = $(this).html();
          $("#book-select-result").html(element);
          let bookImg = $(this)
            .find("img")
            .prop("src");
          let bookTitle = $(this)
            .find("span")
            .text();
          let bookLink = $(this)
            .find("input")
            .val();
          $("#post_link_url")
            .val(bookLink)
            .change();
          $("#post_link_title").val(bookTitle);
          $("#post_link_image").val(bookImg);
          $(".book-list__item").hide();
        })
        .fail(function() {
          window.alert("読み込みエラー");
        });
    }
  );

  // 投稿詳細非表示
  // $(".main-container").on("change", "#content-remove-check", function() {
  //   $.ajax({
  //     url: "/ajax",
  //     type: "get",
  //     dataType: "json"
  //   })
  //     .done(function(data) {
  //       $("#post-data post-list__item").remove();
  //       console.log("ddeeedeleleelte");
  //     })
  //     .fail(function() {
  //       window.alert("読み込みエラー");
  //     });
  // });

  // 本検索結果表示
  // $("#panel-area").on("click", "#book-serch", function() {
  //   $.ajax({
  //     url: "/ajax",
  //     type: "get",
  //     dataType: "json"
  //   })
  //     .done(function(data) {
  //       console.log("検索ボタンがクリックされました！");
  //       let testData = $("#test-list").text();
  //       console.log(testData);
  //       $("#book-list").on("click", "#test-list", function() {
  //         console.log("ブックリストがクリックされました！");
  //       });
  //     })
  //     .fail(function() {
  //       window.alert("読み込みエラー");
  //     });
  // });
  // $("#book-list").on("click", ".book-list__item", function() {
  //   $.ajax({
  //     url: "/ajax",
  //     type: "get",
  //     dataType: "json"
  //   })
  //     .done(function(data) {
  //       console.log("本検索！！！！");
  //     })
  //     .fail(function() {
  //       window.alert("読み込みエラー");
  //     });
  // });

  // フォロー、フォロー解除ボタン
  // $(" .profile-block__link").click(function() {
  // $("#follow_form").on("click", ".profile-block__link", function() {
  //   $.ajax({
  //     url: "/status",
  //     type: "get",
  //     dataType: "json"
  //   })
  //     .done(function(data) {
  //       let hiddenData = $("#followers-count").text();
  //       console.log(hiddenData);
  //       let ID = $("#followed_id").prop("value");
  //       console.log(ID);
  //     })
  //     .fail(function() {
  //       window.alert("読み込みエラー");
  //     });
  // });
});
