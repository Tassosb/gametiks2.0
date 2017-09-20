// var interval = null;
// var imageIndex = 0;
// var totalImages = gon.harvestCount;
//
// // clears animation and renders staff pick image.
// // must toggle visible containers depending on which is currently rendered.
// $(document).ready(function() {
//   $('#staff-pick-button').click(function() {
//     const staffPickVisible = ($('#staff-pick-container').css('display') === 'block')
//     if (staffPickVisible) {
//       $('#staff-pick-container').hide();
//       $('#slideshow-container-flex').empty();
//       runSlideshow();
//     } else {
//       $('#title-container').fadeOut(10);
//       $('#slideshow-container-flex').empty();
//       $('#slideshow-container-block').hide();
//       $('#staff-pick-container').show();
//       $('#bottom-row').hide();
//     }
//   });
// });
//
// // function cycles through harvests from most recent to least recent,
// // grabbing one image at a time and updating the index
// // slideshow is viewable on homepage
// var runSlideshow = function() {
//
//   var renderLoadingNotification = function() {
//     $('#slideshow-container-flex').html('loading recent harvests');
//   };
//
//   var getNextImage = function() {
//     $.ajax({
//       type: 'GET',
//       url: '/slideshow',
//       dataType: 'script',
//       data: {
//         harvest: {
//           imageIndex: imageIndex
//         }
//       }
//     }).done(function() {
//       if (imageIndex + 1 < totalImages) {
//         imageIndex ++;
//       } else {
//         imageIndex = 0;
//       };
//     });
//   };
//
//   var resumeSlideshow = function() {
//     // clearInterval(interval);
//     // imageIndex = 0;
//     // if any slide is remaining, clear it before rendering container
//     $('#slideshow-container-flex').empty();
//     $('#slideshow-container-block').show(function() {
//       renderLoadingNotification();
//       // grab first image initially to avoid 3-second delay, then resume with interval
//       getNextImage(function() {
//         interval = setInterval(getNextImage, 3500);
//       });
//     });
//   };
//
//   $('#title-container').fadeOut(100, function() {
//     resumeSlideshow();
//   });
//
// }; // end slideshow
//
// // fires slideshow on page load;
// $(document).ready(function() {
//   // fade in main title
//   if (window.location.pathname == '/') {
//     if ($('#sign-up-buttons-container').length === 0) {
//       $('#title-container').css('padding-top', '30px');
//       $('#title-container').animate({
//         opacity: 1.0
//       }, 500);
//     } else {
//       $('#title-container').animate({
//         opacity: 1.0
//       }, 500);
//     };
//
//     runSlideshow();
//   };
// });
