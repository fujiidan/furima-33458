function price() {
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener("input", () => {
    const priceDate = document.getElementById("item-price");
    const price = parseInt(priceDate.value, 10) || 0;
    const taxDate = document.getElementById("add-tax-price");
    const profitDate = document.getElementById("profit");

    const tax = Math.floor(price * 0.1);
    const profit = price - tax;
    
    taxDate.innerHTML = tax;
    profitDate.innerHTML = profit;
  });
}

window.addEventListener("load", price);