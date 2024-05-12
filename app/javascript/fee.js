window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
   priceInput.addEventListener("input", () => {
     const addTax = document.getElementById("add-tax-price");
     addTax.innerHTML = Math.floor(priceInput.value * 0.1 );
     const addProfit = document.getElementById("profit");
     addProfit.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
 })

});