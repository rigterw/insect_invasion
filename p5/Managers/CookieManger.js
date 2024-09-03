class CookieManager {
    cookies = {};
    constructor() {
        this.setDate();
        this.loadCookies();
    }

    setDate() {
        let date = new Date();
        date.setTime(date.getTime() + 34560000000);
        this.exDate = "expires=" + date.toUTCString();
    }

    loadCookies() {
        const cookies = document.cookie.split('; ');

        cookies.forEach(cookie => {
            const [key, value] = cookie.split('=');

            this.setCookie(key, decodeURIComponent(value));
        });
    }

    getCookie(name) {
        return this.cookies[name] == null ? 0 : this.cookies[name];
    }

    setCookie(name, value) {
        document.cookie = `${name}=${value};${this.exDate};path=/`;
        this.cookies[name] = value;
    }
}