pragma solidity ^0.5.1;

contract Student
{
    struct student{
        string name;
        uint id;
        address student;
        string course;
        bool status;
        
    }
    mapping(address => uint) feespaid;
    student[]  public studentList;
    uint studentcount;
    address registrar;
    event registered(address studentaddr, uint fees);
    
    constructor() public
    {
        registrar=msg.sender;
        studentcount =0;
    }
    modifier onlyRegistrar()
    {
        require(msg.sender==registrar);
        _;
    }

   function Register(string memory _name,uint _id,address _student,string memory _course) public onlyRegistrar
   {
       studentList.push(student(_name,_id,_student,_course,false));
       studentcount++;
       
   }
   
   function Payfees(uint index)public payable
   {
       require(msg.value==1 ether);
       feespaid[studentList[index].student]=msg.value;
       studentList[index].status=true;
       emit registered(studentList[index].student,msg.value);
   }
   function checkfees(uint index) private view returns(uint)
   {
       return feespaid[studentList[index].student];
   }
   function callcheckfees(uint index) public view returns(uint)
   {
       uint amount=checkfees(index);
       return amount;
       
   }
    
}