function initAutocomplete() {
    const autocompleteElement = document.getElementById("searchInput");

    autocompleteElement.addEventListener("gmp-placechange", () => {
        const place = autocompleteElement.value; // 문자열 주소
        const placeDetails = autocompleteElement.getPlace(); // PlaceResult 객체

        if (!placeDetails.geometry) {
            console.error("No geometry found for the selected place.");
            return;
        }

        document.getElementById("restName").value = placeDetails.name || "";
        document.getElementById("address").value = placeDetails.formatted_address || "";
        document.getElementById("latitude").value = placeDetails.geometry.location.lat();
        document.getElementById("longitude").value = placeDetails.geometry.location.lng();
    });
}
