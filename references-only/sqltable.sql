-- 1) Create the enum type for exceptions
create type exception_type as ENUM('REDUCED', 'EXEMPT');

-- 2) Create households table
create table households (id SERIAL primary key, name VARCHAR(100) not null);

-- 3) Create categories table
create table categories (
  id SERIAL primary key,
  household_id INT not null references households (id),
  name VARCHAR(100) not null unique
);

-- 4) Create users table
create table users (
  id SERIAL primary key,
  household_id INT not null references households (id),
  display_name VARCHAR(100) not null,
  email VARCHAR(255) unique,
  monthly_income DECIMAL(10, 2)
);

-- 5) Create expenses table
create table expenses (
  id SERIAL primary key,
  household_id INT not null references households (id),
  category_id INT not null references categories (id),
  description VARCHAR(255),
  total_amount DECIMAL(10, 2) not null,
  expense_date DATE default CURRENT_DATE
);

-- 6) Create user_expenses table
create table user_expenses (
  id SERIAL primary key,
  expense_id INT not null references expenses (id),
  user_id INT not null references users (id),
  amount_paid DECIMAL(10, 2)
);

-- 7) Create exceptions table
create table exceptions (
  id SERIAL primary key,
  user_id INT not null references users (id),
  category_id INT references categories (id),
  exception_type exception_type not null,
  percent DECIMAL(5, 2)
);