/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author NCPC
 */
public class Product {

    private int id;
    private String name;
    private double price;
    private int quantity;
    private int sold;
    private String factory;
    private String cpuCategory;
    private String cpu;
    private String ram;
    private String rom;
    private String screen;
    private String vga;
    private String target;
    private String shortDesc;
    private String detailDesc;
    private String image;
    private int storage;

    public Product() {
    }

    public Product(int id, String name, double price, int quantity, int sold, String factory, String cpuCategory, String cpu, String ram, String rom, String screen, String vga, String target, String shortDesc, String detailDesc, String image, int storage) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.sold = sold;
        this.factory = factory;
        this.cpuCategory = cpuCategory;
        this.cpu = cpu;
        this.ram = ram;
        this.rom = rom;
        this.screen = screen;
        this.vga = vga;
        this.target = target;
        this.shortDesc = shortDesc;
        this.detailDesc = detailDesc;
        this.image = image;
        this.storage = storage;
    }

    public Product(String name, double price, int quantity, int sold, String factory, String cpuCategory, String cpu, String ram, String rom, String screen, String vga, String target, String shortDesc, String detailDesc, String image, int storage) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.sold = sold;
        this.factory = factory;
        this.cpuCategory = cpuCategory;
        this.cpu = cpu;
        this.ram = ram;
        this.rom = rom;
        this.screen = screen;
        this.vga = vga;
        this.target = target;
        this.shortDesc = shortDesc;
        this.detailDesc = detailDesc;
        this.image = image;
        this.storage = storage;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getCpuCategory() {
        return cpuCategory;
    }

    public void setCpuCategory(String cpuCategory) {
        this.cpuCategory = cpuCategory;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getRom() {
        return rom;
    }

    public void setRom(String rom) {
        this.rom = rom;
    }

    public String getScreen() {
        return screen;
    }

    public void setScreen(String screen) {
        this.screen = screen;
    }

    public String getVga() {
        return vga;
    }

    public void setVga(String vga) {
        this.vga = vga;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStorage() {
        return storage;
    }

    public void setStorage(int storage) {
        this.storage = storage;
    }

}
