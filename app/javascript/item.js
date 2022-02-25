function count (){
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  itemPrice.addEventListener("input", () => {
    const numItemPrice = Math.floor(Number(itemPrice.value));
    const numAddTaxPrice = Math.floor(numItemPrice * 0.1);
    addTaxPrice.innerHTML = new Intl.NumberFormat('ja-JP').format(numAddTaxPrice);
    profit.innerHTML = new Intl.NumberFormat('ja-JP').format(numItemPrice - numAddTaxPrice);
  });
};

window.addEventListener('load', count);