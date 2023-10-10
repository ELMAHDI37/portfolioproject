

--cleaning data in SQL queries

SELECT *
FROM [portfolio project].[dbo].[nashvillehousing]

------------------------------------------------------------------------

--Standardize data format
SELECT saleDate, convert(date,saleDate)
FROM [portfolio project].[dbo].[nashvillehousing]

update nashvillehousing 
set SaleDate = convert(date,SaleDate)

ALTER TABLE nashvillehousing 
ADD Saledataconverted date;

update nashvillehousing 
set Saledataconverted = convert(date,SaleDate)


------------------------------------------------------------------------ 
--populate property address data

SELECT * -- propertyaddress
FROM [portfolio project].[dbo].[nashvillehousing]

--where propertyaddress is null

Select A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
FROM [portfolio project].[dbo].[nashvillehousing] A
join [portfolio project].[dbo].[nashvillehousing] B
   on A.ParcelID = B.ParcelID
   and A.UniqueID <> B.UniqueID 
 WHERE A.PropertyAddress is null


 update A 
 Set PropertyAddress = ISNULL(A.PropertyAddress,B.PropertyAddress)
FROM [portfolio project].[dbo].[nashvillehousing] A
join [portfolio project].[dbo].[nashvillehousing] B
   on A.ParcelID = B.ParcelID
   and A.UniqueID <> B.UniqueID 
 WHERE A.PropertyAddress is null


 --------------------------------------------------------
 --breaking out address into individual columns (address, city, state)

 SELECT
 SUBSTRING (propertyAddress, 1, CHARINDEX(',', propertyAddress)-1) as address
  , SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , len(propertyAddress)) as address
 FROM [portfolio project].[dbo].[nashvillehousing]



 ALTER TABLE [portfolio project].[dbo].[nashvillehousing] 
ADD propertysplitAddress Nvarchar(255);

update [portfolio project].[dbo].[nashvillehousing]
set propertysplitAddress = SUBSTRING (propertyAddress, 1, CHARINDEX(',', propertyAddress)-1)


ALTER TABLE [portfolio project].[dbo].[nashvillehousing]
ADD propertysplitcity Nvarchar(255);

update [portfolio project].[dbo].[nashvillehousing]
set propertysplitcity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , len(propertyAddress))




SELECT  OwnerAddress
FROM [portfolio project].[dbo].[nashvillehousing]




SELECT 
PARSENAME (REPLACE(ownerAddress, ',', '.') , 3)
,PARSENAME (REPLACE(ownerAddress, ',', '.') , 2)
,PARSENAME (REPLACE(ownerAddress, ',', '.') , 1)
FROM [portfolio project].[dbo].[nashvillehousing]

 ALTER TABLE [portfolio project].[dbo].[nashvillehousing] 
ADD ownersplitAddress Nvarchar(255);

update [portfolio project].[dbo].[nashvillehousing]
set ownersplitAddress = PARSENAME (REPLACE(ownerAddress, ',', '.') , 3)

 ALTER TABLE [portfolio project].[dbo].[nashvillehousing] 
ADD ownersplitcity Nvarchar(255);

update [portfolio project].[dbo].[nashvillehousing]
set ownersplitcity = PARSENAME (REPLACE(ownerAddress, ',', '.') , 2)

 ALTER TABLE [portfolio project].[dbo].[nashvillehousing] 
ADD ownersplitstate Nvarchar(255);

update [portfolio project].[dbo].[nashvillehousing]
set ownersplitstate = PARSENAME (REPLACE(ownerAddress, ',', '.') , 1)


SELECT  *
FROM [portfolio project].[dbo].[nashvillehousing]

\


---------------------------------------------------------------------
-- Change Y and N to YES and NO in "sold as vacant " field

SELECT DISTINCT (SoldAsVacant),COUNT(SoldAsVacant)
FROM [portfolio project].[dbo].[nashvillehousing]
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldAsVacant
,CASE when SoldAsVacant = 'Y' then 'yes'
      when SoldAsVacant = 'N' then 'NO'
	  ELSE SoldAsVacant
	  END
FROM [portfolio project].[dbo].[nashvillehousing]


UPDATE [portfolio project].[dbo].[nashvillehousing]
SET SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'yes'
      when SoldAsVacant = 'N' then 'NO'
	  ELSE SoldAsVacant
	  END


--------------------------------------------------------------------
---REMOVE DUPLICATES


WITH rownumCTE AS (
SELECT*,
    ROW_NUMBER() OVER (
	Partition by parcelID,
	             propertyAddress,
				 SalePrIce,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID ) row_num

FROM [portfolio project].[dbo].[nashvillehousing]
)


DELETE
FROM  rownumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress


--------------------------------------------------------------------------------------
----DELETE UNUSED COLUMNS

SELECT *
FROM [portfolio project].[dbo].[nashvillehousing]

ALTER TABLE [portfolio project].[dbo].[nashvillehousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress
