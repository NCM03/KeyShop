﻿using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;
using ShopKey.Models;

namespace ShopKey.Controllers
{
    public class ProductKeyController : Controller
    {
        public bool CanAccessThisManagementPage()
        {
            string? useAcc = HttpContext.Session.GetString("userAcc");
            if (useAcc != null)
            {
                var userInf =CuongNMContext.INSTANCE.Users.Find(useAcc);
                if (userInf != null)
                {
                    if (userInf.RoleRoleId != 1 && userInf.IsActive == true)
                    {
                        var roleList =CuongNMContext.INSTANCE.Roles.ToArray();
                        ViewBag.userInf = userInf;
                        ViewBag.roleList = roleList;
                        return true;
                    }
                }
            }
            if (HttpContext.Session.Keys.Contains("userAcc"))
            {
                HttpContext.Session.Remove("userAcc");
            }
            return false;
        }

        public IActionResult Index()
        {
            bool canAccess = CanAccessThisManagementPage();
            if (canAccess)
            {
                var keyList =CuongNMContext.INSTANCE.ProductKeys.ToArray();
                ViewBag.keyList = keyList;
                var prdList =CuongNMContext.INSTANCE.Products.ToArray();
                ViewBag.prdList = prdList;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        // ================ Create Product Key ================
        public IActionResult Create()
        {
            bool canAccess = CanAccessThisManagementPage();
            if (canAccess)
            {
                var prdList =CuongNMContext.INSTANCE.Products.ToArray();
                ViewBag.prdList = prdList;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
        [HttpPost]
        public IActionResult Create(IFormCollection f)
        {
            try
            {


                int productId = Int32.Parse(f["productId"]);
                if (productId != null)
                {
                    string keyValue = f["keyValue"];
                    string? expirationDateStr = f["expirationDate"];
                    if (expirationDateStr.Equals(""))
                    {
                        expirationDateStr = null;
                    }
                    ProductKey prdKey = new ProductKey()
                    {
                        ProductProductId = productId,
                        ProductKey1 = keyValue,
                        ExpirationDate = expirationDateStr,
                        IsExpired = false
                    };
                    CuongNMContext.INSTANCE.ProductKeys.Add(prdKey);
                    CuongNMContext.INSTANCE.SaveChanges();
                    ViewBag.mess = "Add new key successfully!";
                }
            }
            catch (Exception ex)
            {


                ViewBag.mess = "Failed Empty ProductID. Please Before add choose ProductID";
            }
           
            return Redirect("/ProductKey/Create");
        }
       
        public IActionResult Delete(int Id)
        {
            bool canAccess = CanAccessThisManagementPage();
            if (canAccess)
            {
                var prdKey =CuongNMContext.INSTANCE.ProductKeys.Find(Id);
                if (prdKey != null)
                {
                   CuongNMContext.INSTANCE.ProductKeys.Remove(prdKey);
                   CuongNMContext.INSTANCE.SaveChanges();
                }
                else
                {
                    TempData["deleteProductKeyErr"] = "This product key does not exist!";
                }
                return RedirectToAction("Index", "ProductKey");
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
        // =================================================

        // ================ Update Product Key ================
        public IActionResult Update(int Id)
        {
            bool canAccess = CanAccessThisManagementPage();
            if (canAccess)
            {
                var prdKeyDetail =CuongNMContext.INSTANCE.ProductKeys.Find(Id);
                ViewBag.prdKeyDetail = prdKeyDetail;
                if (prdKeyDetail != null)
                {
                    var prdDetail =CuongNMContext.INSTANCE.Products.Find(prdKeyDetail.ProductProductId);
                    ViewBag.prdDetail = prdDetail;
                }
                else
                {
                    return RedirectToAction("Index", "ProductKey");
                }
                var prdList =CuongNMContext.INSTANCE.Products.ToArray();
                ViewBag.prdList = prdList;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public IActionResult Update(IFormCollection f)
        {
            int keyId = Int32.Parse(f["keyId"]);
            var editingPrdKey =CuongNMContext.INSTANCE.ProductKeys.Find(keyId);
            if (editingPrdKey != null)
            {
                int productId = Int32.Parse(f["productId"]);
                string keyValue = f["keyValue"];
                if (keyValue.Equals(""))
                {
                    keyValue = editingPrdKey.ProductKey1;
                }
                string? expirationDate = f["expirationDate"];
                if (expirationDate.Equals(""))
                {
                    expirationDate = null;
                }

                editingPrdKey.ProductProductId = productId;
                editingPrdKey.ExpirationDate = expirationDate;
                editingPrdKey.ProductKey1 = keyValue;

               CuongNMContext.INSTANCE.ProductKeys.Update(editingPrdKey);
               CuongNMContext.INSTANCE.SaveChanges();
            }
            return RedirectToAction("Index", "ProductKey");
        }
        // ================================================
    }
}
