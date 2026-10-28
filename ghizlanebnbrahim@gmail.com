// 1. Données de départ
const produits = [
  { id: 1, nom: "Clavier", categorie: "Accessoires", prix: 120, stock: 5 },
  { id: 2, nom: "Souris", categorie: "Accessoires", prix: 80, stock: 8 },
  { id: 3, nom: "Écran", categorie: "Informatique", prix: 900, stock: 0 },
  { id: 4, nom: "Casque", categorie: "Accessoires", prix: 240, stock: 3 }
];

// --- Travail demandé ---

console.log("--- 1. Affichage du catalogue ---");
produits.forEach(produit => {
  console.log(`${produit.nom} : ${produit.prix} MAD`);
});

console.log("\n--- 2. Disponibilité ---");
const produitsDisponibles = produits.filter(produit => produit.stock > 0);
console.log(`Nombre de produits disponibles : ${produitsDisponibles.length}`);

console.log("\n--- 3. Valeur du stock ---");
const valeurStock = produits.reduce((total, produit) => {
  return total + (produit.prix * produit.stock);
}, 0);
console.log(`Valeur totale du stock : ${valeurStock} MAD`);

console.log("\n--- 4. Prix minimal ---");
function trouverMoinsCher(listeProduits) {
  if (listeProduits.length === 0) {
    return null;
  }
  return listeProduits.reduce((min, produit) => {
    return produit.prix < min.prix ? produit : min;
  });
}

const moinsCher = trouverMoinsCher(produitsDisponibles);

if (moinsCher) {
  // Bonus: Déstructuration
  const { nom, prix } = moinsCher;
  console.log(`Le produit disponible le moins cher est : ${nom} (${prix} MAD)`);
} else {
  console.log("Aucun produit n'est disponible pour le moment.");
}

console.log("\n--- 5. Résumé ---");
const resume = produits.map(produit => {
  return `${produit.nom} - ${produit.prix} MAD - ${produit.stock} unités`;
});
resume.forEach(ligne => console.log(ligne));

// --- Défi supplémentaire (Bonus) ---
console.log("\n--- Défi : Validation ---");
function estValide(produit) {
  const prixValide = typeof produit.prix === 'number' && Number.isFinite(produit.prix) && produit.prix >= 0;
  const stockValide = typeof produit.stock === 'number' && Number.isFinite(produit.stock) && produit.stock >= 0;
  return prixValide && stockValide;
}
console.log(`Le produit Clavier est-il valide ? ${estValide(produits[0])}`);
