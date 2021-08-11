class Doctor{
  int id;
String name,slug,price,description,image;

Doctor(this.id,this.name, this.slug, this.price, this.description, this.image);

Doctor.fromJson(Map<String,dynamic>jsonObject){
  this.id = jsonObject['id'];
  this.name = jsonObject['name'];
  this.slug = jsonObject['slug'];
  this.image = jsonObject['images'];
  this.description = jsonObject['description'];
  this.price = jsonObject['price'];
}

}