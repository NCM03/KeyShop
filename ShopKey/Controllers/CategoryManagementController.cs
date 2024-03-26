using ShopKey.Models;
using Microsoft.AspNetCore.Mvc;

namespace License_Key_Shop_Web.Controllers
{
    public class CategoryManagementController : Controller
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
                var cateList =CuongNMContext.INSTANCE.Categories.ToArray();
                ViewBag.cateList = cateList;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        // ================ Create CATEROGY ================
        [HttpPost]
        public IActionResult Create(IFormCollection f)
        {
            string categoryName = f["categoryName"];
            var cateList =CuongNMContext.INSTANCE.Categories.ToArray();
            Boolean isExisted = false;
            foreach (var item in cateList)
            {
                if (item.CategoryName.ToLower().Equals(categoryName.ToLower()))
                {
                    isExisted = true;
                }
            }

            if (isExisted == true)
            {
                TempData["AddCategoryErr"] = "This category already exist!";
            }
            else
            {
                Category category = new Category() { CategoryName = categoryName };
               CuongNMContext.INSTANCE.Categories.Add(category);
               CuongNMContext.INSTANCE.SaveChanges();
                TempData["AddCategorySuccess"] = "Add new category successfully!";
            }
            return RedirectToAction("Index", "CategoryManagement");
        }
        // =================================================

        // ================ Update CATEROGY ================
        [HttpPost]
        public IActionResult Update(IFormCollection f)
        {
            int categoryID = int.Parse(f["categoryID"]);
            String categoryName = f["categoryName"];
            var cate =CuongNMContext.INSTANCE.Categories.Find(categoryID);
            if (cate != null)
            {
                cate.CategoryName = categoryName;
               CuongNMContext.INSTANCE.Categories.Update(cate);
               CuongNMContext.INSTANCE.SaveChanges();
                TempData["updateCategorySuccess"] = "Update category successfully!";
            }
            else
            {
                TempData["updateCategoryErr"] = "This category does not exist!";
            }
            return RedirectToAction("Index", "CategoryManagement");
        }
        // =================================================
        // ================ Delete CATEROGY ================
        public IActionResult Delete(int Id)
        {
            bool canAccess = CanAccessThisManagementPage();
            if (canAccess)
            {
                var cate =CuongNMContext.INSTANCE.Categories.Find(Id);
                if (cate != null)
                {
                    var prdList =CuongNMContext.INSTANCE.Products
                        .Where(prdoduct => prdoduct.CategoryCategoryId == Id)
                        .Select(entity => new
                        {
                            entity.ProductId,
                        });
                    foreach (var prd in prdList)
                    {
                        if (prd != null)
                        {
                            // Get product key list to delete first
                            var productKetList =CuongNMContext.INSTANCE.ProductKeys
                                .Where(key => key.ProductProductId == prd.ProductId)
                                .Select(entity => new
                                {
                                    entity.KeyId,
                                });
                            // Delete key of this product if exist
                            if (productKetList != null)
                            {
                                foreach (var key in productKetList)
                                {
                                    var keyInf =CuongNMContext.INSTANCE.ProductKeys.Find(key.KeyId);
                                    if (keyInf != null)
                                    {
                                       CuongNMContext.INSTANCE.ProductKeys.Remove(keyInf);
                                    }
                                }
                            }

                            // Get product int cart list to delete
                            var productInCartList =CuongNMContext.INSTANCE.CartItems
                                .Where(cartI => cartI.ProductProductId == prd.ProductId)
                                .Select(entity => new
                                {
                                    entity.ItemId,
                                });
                            // Delete key of this product if exist
                            if (productInCartList != null)
                            {
                                foreach (var cartI in productInCartList)
                                {
                                    var productIncartInf =CuongNMContext.INSTANCE.CartItems.Find(cartI.ItemId);
                                    if (productIncartInf != null)
                                    {
                                       CuongNMContext.INSTANCE.CartItems.Remove(productIncartInf);
                                    }
                                }
                            }

                            // Delete product
                            var productToRemove =CuongNMContext.INSTANCE.Products.Find(prd.ProductId);
                            if (productToRemove != null)
                            {
                               CuongNMContext.INSTANCE.Products.Remove(productToRemove);
                            }
                        }
                    }
                   CuongNMContext.INSTANCE.Categories.Remove(cate);
                   CuongNMContext.INSTANCE.SaveChanges();
                    TempData["deleteCategorySuccess"] = "Delete category successfully!";
                }
                else
                {
                    TempData["deleteCategoryErr"] = "This category does not exist!";
                }
                return RedirectToAction("Index", "CategoryManagement");
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
        // =================================================
    }
}
