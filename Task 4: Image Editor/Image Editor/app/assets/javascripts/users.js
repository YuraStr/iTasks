$(document).ready(function(){
    // disable auto discover
    Dropzone.autoDiscover = false;

    // grap our upload form by its id
    $("#new_upload").dropzone({
        // restrict image size to a maximum 1MB
        maxFilesize: 10,
        // changed the passed param to one accepted by
        // our rails app
        paramName: "upload[image]",
        // show remove links on each image upload
        addRemoveLinks: false
    });
});
