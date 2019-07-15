$(function() {
  let windowWidth = window.innerWidth; //ウィンドウサイズ
  const breakPoint = 1120;

  let topPosition, nowPosition;
  $(window).scroll(function() {
    topPosition = $(window).scrollTop(); // スクロールトップポジションを取得
  });

  // let nowPositions = () => {
  //   let topPosition, nowPosition;
  //   $(window).scroll(function() {
  //     topPosition = $(window).scrollTop(); // スクロールトップポジションを取得
  //   });
  //   nowPosition = topPosition;
  //   return nowPosition;
  // };
  // console.log(nowPositions());

  // 投稿モーダル 表示
  $("#modal-open").click(function() {
    nowPosition = topPosition; //クリック時の位置取得
    $("body").toggleClass("active");
    if (windowWidth >= breakPoint) {
      $("#modal-content--post, #modal-close--post").fadeIn();
      $("#modal-content--post").css("top", nowPosition + 50);
      $("#modal-close--post").css("top", nowPosition);
      $("#modal-close--post").addClass("active");
    } else {
      $("#modal-content--post").fadeIn();

      $("#modal-close--post, #modal-content--post").css("top", 0);
      $("main, footer").hide();
    }
  });

  // -- モーダルを閉じる --
  const closeModal = function() {
    $("#modal-content--post, #modal-close--post").fadeOut("fast");
    $("body").removeClass("active");
    $(window).scrollTop(nowPosition); //クリック時の位置
    console.log(nowPosition);
  };
  $("#close-btn--tab").click(function() {
    $("main, footer").show();
    closeModal();
  });
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#modal-content--post, #modal-open").length) {
      closeModal();
    }
  });

  // // 投稿モーダル 表示
  // $("#modal-checkbox--post").change(function() {
  //   $(window).scroll(function() {
  //     topPosition = $(window).scrollTop(); // スクロールトップポジションを取得
  //   });
  //   const nowPosition = topPosition; //クリック時の位置取得
  //   if (windowWidth >= breakPoint) {
  //     $("#modal-content--post").css("top", nowPosition + 50);
  //     $("#modal-close--post").css("top", nowPosition);
  //   } else {
  //     $("#modal-close--post, #modal-content--post").css("top", 0);
  //     $("main, footer").hide();
  //   }
  //   $("body").toggleClass("active");
  //   if ($(this).prop("checked") == true) {
  //     $("#modal-content--post").fadeIn();
  //   } else {
  //     $("#modal-content--post").fadeOut("fast");
  //     console.log(nowPosition);
  //     if (windowWidth < breakPoint) {
  //       $(window).scrollTop(nowPosition); //クリック時の位置
  //       $("main, footer").show();
  //     }
  //   }
  // });
});
