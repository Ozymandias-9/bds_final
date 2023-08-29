module.exports = {
    missingFields: function (body) {
        const fields = Object.values(body);

        let missing = false;

        fields.forEach(field => {
            if (field === '') {
                missing = true;
            }
        })

        return missing;
    }
}