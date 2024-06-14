/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function addItemToCart(_title, _img, _price, _quantity) {
    console.log('Title:', _title);
    console.log('Image:', _img);
    console.log('Price:', _price);
    console.log('Quantity:', _quantity);
    console.log(_price * _quantity);
    console.log(document.getElementById('quantity').value); // Check if quantity element exists

    const cartList = document.getElementById("list-of-cart");
    const newRow = document.createElement("li");
    const totalCost =_price * _quantity;
  
    newRow.style.display = "flex";
    newRow.style.marginBottom = "4px";
    newRow.style.borderBottom = "1px solid #000";
    newRow.style.paddingBottom  = "4px";
    newRow.style.lineHeight  = "1.4";
        
    newRow.innerHTML = `
        <img style="width: 60px; height: 60px; padding: 2px; margin-right: 8px" src="${_img}" alt="product" /> 
        <div>
            <h4>${_title}</h4> 
            <h5>Price: ${totalCost}$</h5>
            <h5>Quantity: ${_quantity}</h5>
            <span class="remove-item">Remove</span>
        </div>
                <hr>

    </li>`;
    cartList.append(newRow);
    
    document.getElementById("number-item-cart").textContent = parseInt(document.getElementById("number-item-cart").textContent) + 1;
    
}

